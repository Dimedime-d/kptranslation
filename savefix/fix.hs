{- 
Only purpose of making this in Haskell is to have a convenient .exe to drag and drop the save file on to.
-}
module Main where

import System.Environment(getArgs)
import System.IO (stdout)
import Control.Exception (try, IOException)
import qualified Data.ByteString.Lazy as B (ByteString, fromChunks, drop, hGet, unpack, pack, take, readFile, writeFile)
import qualified Data.ByteString as S
import Data.ByteString.Char8 as C (pack)
import Data.Word
import Data.Binary
import Data.Binary.Get
import Data.Binary.Put
import Control.Monad
import Prelude hiding (writeFile, readFile)

makeError::String->String
makeError = ("ERROR: " ++)

isFlag::String->Bool
isFlag [] = False
isFlag x = (=='-') . head $ x

isOption::String->Bool
isOption = (=="--") . take 2

getOptions::[String]->[String]
getOptions = filter isOption

getUnflaggedParams::[String]->[String]
getUnflaggedParams [] = []
getUnflaggedParams argv = (map snd . filter (\(a,b)->(not (isFlag a) || isOption a) && not (isFlag b)) $ ([], head argv):zip argv (tail argv))

stripExtension::String->String
stripExtension str = let base = reverse . tail $ dropWhile (/= '.') (reverse str) in
    case base of 
        [] -> str
        x  -> x
        
onlyExtension::String->String
onlyExtension str = let base = tail $ dropWhile (/= '.') (str) in
    case base of 
        [] -> str
        x  -> x
        
editedFileName::String->String
editedFileName str = stripExtension str ++ "-fixed." ++ onlyExtension str

validateHeader::B.ByteString->Bool
validateHeader dat = (show $ B.take 8 dat) == "\"KURUPARA\""

replaceName :: S.ByteString -> S.ByteString
replaceName arr = case S.unpack(arr) of
    [0xB8,0xD9,0xD8,0xDD,0xE9,_   ,_   ,_] -> C.pack "Totorin\0"
    [0xCF,0xBC,0xDE,0xAF,0xB8,_   ,_   ,_] -> C.pack "Magic\0\0\0"
    [0x93,0x9B,0x97,0xDE,_   ,_   ,_   ,_] -> C.pack "Hare\0\0\0\0"
    [0xCB,0xAE,0xBA,0xD8,0xDD,_   ,_   ,_] -> C.pack "Hyokorin"
    [0xB6,0xB8,0xD8,0xDD,_   ,_   ,_   ,_] -> C.pack "Kakurin\0"
    [0xCF,0xD8,0xD8,0xDD,_   ,_   ,_   ,_] -> C.pack "Maririn\0"
    [0xD7,0xCC,0xDE,0xD8,0xDD,_   ,_   ,_] -> C.pack "Loverin\0"
    [0xC1,0xB8,0xD8,0xDD,_   ,_   ,_   ,_] -> C.pack "Chikurin"
    [0xB9,0xDE,0xB7,0xD8,0xDD,_   ,_   ,_] -> C.pack "Gekirin\0"
    [0xCC,0xDC,0xD8,0xDD,_   ,_   ,_   ,_] -> C.pack "Fuwarin\0"
    [0xCE,0xD6,0xD8,0xDD,_   ,_   ,_   ,_] -> C.pack "Hoyorin\0"
    [0xCB,0xDF,0xB6,0xD8,0xDD,_   ,_   ,_] -> C.pack "Pikarin\0"
    [0xCE,0xDF,0xBA,0xD8,0xDD,_   ,_   ,_] -> C.pack "Pokorin\0"
    otherwise -> arr

replaceNames::B.ByteString->([Word8], [Word8])
replaceNames dat = (bin, chkSum')
    where
        arrs = runGet( replicateM 0x7F5 $ getByteString 8) dat
        arrs2 = Prelude.map replaceName arrs
        bin = B.unpack $ runPut (mapM_ putByteString arrs2)
        chkSum = sum $ Prelude.map fromIntegral $ bin
        chkSum' = B.unpack $ encode $ byteSwap16 (chkSum :: Word16)

modify::B.ByteString->B.ByteString
modify f_in = B.fromChunks [S.pack header, S.pack mainDat, S.pack rest]
    where
        rest = B.unpack $ B.drop 0x3FC0 $ B.take 0x10000 f_in
        (mainDat, chkSum) = replaceNames $ B.drop 0x18 $ B.take 0x3FC0 f_in
        header = B.unpack $ B.fromChunks [C.pack "KURUPARA 0.06\0\0\0\0\0", S.pack chkSum, S.pack chkSum, C.pack "\255\255"]

main::IO ()
main = do
    argv <- getArgs
    let options = getOptions argv
    let params = getUnflaggedParams argv
    if elem "--help" options
    then putStr $ "Usage: ./SaveFix <savefile>"
    else if length params /= 1
    then putStr $ makeError "Incorrect number of parameters. Use ./SaveFix --help for usage."
    else do
        let inputFileName = head params
        result <- (try (B.readFile inputFileName)::IO (Either IOException B.ByteString))
        case result of
            Left exception -> putStr $ makeError ("Could not find or read file " ++ inputFileName ++ ".")
            Right inputData -> do
                case validateHeader inputData of
                    False -> putStr $ makeError ("Not an uncompressed KURUPARA save file.")
                    True -> do
                        let finalData = modify inputData
                        B.writeFile (editedFileName inputFileName) finalData
                        return ()
                        