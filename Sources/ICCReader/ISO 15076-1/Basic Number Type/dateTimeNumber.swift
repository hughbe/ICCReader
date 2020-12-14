//
//  dateTimeNumber.swift
//  
//
//  Created by Hugh Bellamy on 11/12/2020.
//

import DataStream

/// [ICC.1:2010] 4.2 dateTimeNumber
/// A dateTimeNumber is a 12-byte value representation of the time and date, where the byte usage is assigned as specified in Table 1.
/// The actual values are encoded as 16-bit unsigned integers (uInt16Number, see 4.10).
/// All the dateTimeNumber values in a profile shall be in Coordinated Universal Time (UTC, also known as GMT or ZULU Time).
/// Profile writers are required to convert local time to UTC when setting these values. Programs that display these values may show the
/// dateTimeNumber as UTC, show the equivalent local time (at current locale), or display both UTC and local versions of the
/// dateTimeNumber.
public struct dateTimeNumber {
    public let year: uInt16Number
    public let month: uInt16Number
    public let day: uInt16Number
    public let hours: uInt16Number
    public let minutes: uInt16Number
    public let seconds: uInt16Number
    
    public init(dataStream: inout DataStream) throws {
        /// 0 to 1 2 Number of the year (actual year, e.g. 1994) uInt16Number
        self.year = try dataStream.read(endianess: .bigEndian)
        
        /// 2 to 3 2 Number of the month (1 to 12) uInt16Number
        self.month = try dataStream.read(endianess: .bigEndian)
        
        /// 4 to 5 2 Number of the day of the month (1 to 31) uInt16Number
        self.day = try dataStream.read(endianess: .bigEndian)
        
        /// 6 to 7 2 Number of hours (0 to 23) uInt16Number
        self.hours = try dataStream.read(endianess: .bigEndian)
        
        /// 8 to 9 2 Number of minutes (0 to 59) uInt16Number
        self.minutes = try dataStream.read(endianess: .bigEndian)
        
        /// 10 to 11 2 Number of seconds (0 to 59) uInt16Number
        self.seconds = try dataStream.read(endianess: .bigEndian)
    }
}
