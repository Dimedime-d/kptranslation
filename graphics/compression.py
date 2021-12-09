from abc import ABC, abstractmethod

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



