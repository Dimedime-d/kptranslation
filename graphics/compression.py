from abc import ABC, abstractmethod
from functools import partial
from struct import unpack, pack

class CompressBase(ABC):
    @abstractmethod
    def compress(self, data):
        pass

class LZ(CompressBase):
    """Custom compression routine that doesn't quite match the one in the GBA BIOS.
    Decompression function in ROM is at offsets 0x92134 and 0x92190."""
    PREFIX_MIN_LENGTH = 3
    
    def compress(orig):
        data = bytearray()
        
        cursor = 0
        while (cursor < len(orig)):
            offset = LZ.findLongestPrefixOffset(orig, cursor) # find position where copying would give most # of bytes
            prefixLen = LZ.prefixLength(orig, cursor + offset, cursor)
            if (prefixLen < LZ.PREFIX_MIN_LENGTH): # not enough copyable data to save space - write raw data
                prefixLen = 1
                while (prefixLen < 0x80 and (prefixLen + cursor < len(orig))
                    and LZ.prefixLength(orig, cursor + prefixLen + LZ.findLongestPrefixOffset(orig, cursor + prefixLen), cursor + prefixLen) < LZ.PREFIX_MIN_LENGTH):
                    prefixLen += 1 # # of bytes to copy before finds a spot where copying would save space
                    
                data.append(prefixLen - 1)
                for i in range(prefixLen):
                    data.append(orig[cursor])
                    cursor += 1
            
            else: # found data to copy
                data.append(0x80 + prefixLen - LZ.PREFIX_MIN_LENGTH)
                data.append(-offset & 0xFF)
                cursor += prefixLen
        return data

    def findLongestPrefixOffset(data, cursor):
        maxL = 0
        res = 0
        leftCursor = cursor - 1
        while (leftCursor >= 0 and cursor - leftCursor < 0xFF): # restrict # of bytes to reference back
            l = LZ.prefixLength(data, leftCursor, cursor)
            if (l > maxL):
                maxL = l
                res = leftCursor - cursor # negative number
            leftCursor -= 1
        return res

    def prefixLength(data, leftCursor, rightCursor):
        if (leftCursor >= rightCursor):
            return 0
        i = 0
        while (rightCursor < len(data) and i < 0x7F + LZ.PREFIX_MIN_LENGTH): #end of data, or copy limit
            if (data[leftCursor] != data[rightCursor]):
                break
            i += 1
            leftCursor += 1
            rightCursor += 1
        return i

class Block: # Helper class for the compression method below
        def __init__(self, data):
            #rows contain LONGS
            self.rows = list()
            dataRows = [data[ 4*i : 4*i+4 ] for i in range(8)]
            for row in dataRows:
                #unpack = bytes -> numbers, endian weirdness
                newRowData = unpack("<l", row)[0]
                self.rows.append(newRowData)

        def isAllZeroes(self):
            for row in self.rows:
                if row != 0:
                    return False
            return True

class ByBlock(CompressBase): # idk what to call this, just that it takes chunks of 32 bytes

    def nibblesToByte(second, first):
    #Ex: If my args are 4 and 9, I want 94
        return (second | (first << 4))

    def compress(dat):
        assert len(dat) % 0x100 == 0, "only multiples of 128 bytes are supported atm"
        bloks = [Block(dat[i:i + 0x20]) for i in range(0, len(dat), 0x20)]
    
        data = bytearray()
        dataToAppend = bytearray()
        tileSwitchMask = 0 #tells when program should change nibbles
        nibblesToAdd = [] #default "last nibble"
        lastNibble = 0
        leftoverNibble = False
        leftoverNibbleFromLastBlock = False
        #*deep breath* first, iterate blocks 8 at a time to set up the TILE MASK
        for i in range (0, len(bloks), 8):
            tileMask = 0xFF
            #iterate each group of 8x8 blocks
            for j in range(8):
                #get current block
                block = bloks[i + j]
                if block.isAllZeroes():
                    #filter out tile in tile mask
                    tileMask ^= (1 << j)
                    
                    #Need to look ahead to the next non-zero block, and take the next nibble
                    blockInd = i + j
                    while (blockInd < len(bloks) and bloks[blockInd].isAllZeroes()):
                        blockInd += 1
                    
                    if blockInd < len(bloks) and leftoverNibble:
                        nibblesToAdd.append(bloks[blockInd].rows[0] & 0xF)
                else:
                    #get into the weeds in here...
                    #Iterate each column of each row
                    for k in range(8): #column
                        for l, row in enumerate(block.rows): #row
                            nibble = (row & (0xF << (k*4))) >> (k*4)
                            if nibble == lastNibble:
                                #nibbles match - do nothing
                                pass
                            else:
                                tileSwitchMask |= (1 << l)
                                nibblesToAdd.append(nibble)
                                lastNibble = nibble #only changed when nibble is different
                                #Add leftovernibble ahead of next tileswitchmask
                                if leftoverNibble:
                                    leftoverNibble = False
                                    byte = ByBlock.nibblesToByte(nibblesToAdd[0],nibblesToAdd[1])
                                    dataToAppend.append(byte)
                                    nibblesToAdd = nibblesToAdd[2:]
                        dataToAppend.append(tileSwitchMask)
                        #print(hex(tileSwitchMask))
                        tileSwitchMask = 0
                        for m, n in zip(nibblesToAdd[0::2], nibblesToAdd[1::2]):
                        #Iterate every group of 2 nibbles (leaving 1 leftover nibble if applicable
                            byte = ByBlock.nibblesToByte(m, n)
                            dataToAppend.append(byte)
                        #Remove every nibble that was added
                        nibblesToAdd = nibblesToAdd[2*(len(nibblesToAdd)//2):]
                        #Case with leftover nibble
                        if nibblesToAdd: #If list is still populated
                            leftoverNibble = True
            if leftoverNibbleFromLastBlock:
                dataToAppend.insert(1, tileMask)
                leftoverNibbleFromLastBlock = False
            else:
                dataToAppend.insert(0, tileMask)
            
            if leftoverNibble:
                leftoverNibbleFromLastBlock = True
            
            for byte in dataToAppend:
                data.append(byte)
            dataToAppend = bytearray()
        return data