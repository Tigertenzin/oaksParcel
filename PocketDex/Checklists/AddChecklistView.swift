//
//  AddChecklistView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/26/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct AddChecklistView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var list = [Bool](repeating: false, count: 810)
    @State private var list_byID = Array(0...806)
    
    @State private var clOptionNames = ["Gen 1 National Dex",
                                        "Gen 2 National Dex",
                                        "Gen 3 National Dex",
                                        "Gen 4 National Dex",
                                        "Gen 5 National Dex",
                                        "Gen 6 National Dex",
                                        "Gen 7 National Dex",
                                        "GSC Regional Dex",
                                        "RSE Regional Dex",
                                        "FRLG Regional Dex",
                                        "DP Regional Dex",
                                        "Pt Regional Dex",
                                        "HGSS Regional Dex",
                                        "BW Regional Dex",
                                        "B2W2 Regional Dex" ,
                                        "XY Regional Dex",
                                        "ORAS Regional Dex",
                                        "SM Regional Dex",
                                        "USUM Regional Dex"]
    
    @State private var selectionIndex = 0

    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Checklist Info")) {
                    TextField("Name of checklist", text: $name)
                    Picker("Checklist Type: ", selection: $selectionIndex) {
                        ForEach(0..<clOptionNames.count, id: \.self) {
                                Text(clOptionNames[$0])
                        }
                    }
                }

                Section {
                    Button("Save") {
                        let newList = Checklist(context: self.moc)
                        newList.id = UUID() 
                        newList.name = self.name
                        newList.type = self.clOptionNames[selectionIndex]
                        newList.checklist = [Bool](repeating: false, count: self.checklistIndices(clType: selectionIndex).count)
                        newList.checklist_byID = self.checklistIndices(clType: selectionIndex)

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Checklist")
        }
    }
    
    func checklistIndices(clType: Int) -> [Int] {
        if clType == 0 {            // Gen 1 National Dex
            return Array(0..<151)
        } else if clType == 1 {     // Gen 2 National Dex
            return Array(0..<251)
        } else if clType == 2 {     // Gen 3 National Dex
            return Array(0..<386)
        } else if clType == 3 {     // Gen 4 National Dex
            return Array(0..<493)
        } else if clType == 4 {     // Gen 5 National Dex
            return Array(0..<649)
        } else if clType == 5 {     // Gen 6 National Dex
            return Array(0..<721)
        } else if clType == 6 {     // Gen 7 National Dex
            return Array(0..<807)
        } else if clType == 7 {     // GSC Regional Dex
            let input = [152,153,154,155,156,157,158,159,160,016,017,018,021,022,163,164,019,020,161,162,172,025,026,010,011,012,013,014,015,165,166,167,168,074,075,076,041,042,169,173,035,036,174,039,040,175,176,027,028,023,024,206,179,180,181,194,195,092,093,094,201,095,208,069,070,071,187,188,189,046,047,060,061,062,186,129,130,118,119,079,080,199,043,044,045,182,096,097,063,064,065,132,204,205,029,030,031,032,033,034,193,191,192,102,103,185,202,048,049,123,212,127,214,109,110,088,089,081,082,100,101,190,209,210,037,038,058,059,234,183,184,050,051,056,057,052,053,054,055,066,067,068,236,106,107,237,203,128,241,240,126,238,124,239,125,122,235,083,177,178,211,072,073,098,099,213,120,121,090,091,222,223,224,170,171,086,087,108,114,133,134,135,136,196,197,116,117,230,207,225,220,221,216,217,231,232,226,227,084,085,077,078,104,105,115,111,112,198,228,229,218,219,215,200,137,233,113,242,131,138,139,140,141,142,143,001,002,003,004,005,006,007,008,009,144,145,146,243,244,245,147,148,149,246,247,248,249,250,150,151,251]
            return subtractArray(input: input)
        } else if clType == 8 {     // RSE Regional Dex
            let input = [252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,063,064,065,290,291,292,293,294,295,296,297,118,119,129,130,298,183,184,074,075,076,299,300,301,041,042,169,072,073,302,303,304,305,306,066,067,068,307,308,309,310,311,312,081,082,100,101,313,314,043,044,045,182,084,085,315,316,317,318,319,320,321,322,323,218,219,324,088,089,109,110,325,326,027,028,327,227,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,174,039,040,349,350,351,120,121,352,353,354,355,356,357,358,359,037,038,172,025,026,054,055,360,202,177,178,203,231,232,127,214,111,112,361,362,363,364,365,366,367,368,369,222,170,171,370,116,117,230,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,]
            return subtractArray(input: input)
        } else if clType == 9 {
            return Array(0...151) // FRLG Regional Dex == Gen 1 dex
        } else if clType == 10 {
            let input = [387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,063,064,065,129,130,406,315,407,041,042,169,074,075,076,095,208,408,409,410,411,066,067,068,054,055,412,412,412,413,413,413,414,265,266,267,268,269,415,416,417,418,419,420,421,422,422,423,423,214,190,424,425,426,427,428,092,093,094,200,429,198,430,431,432,118,119,339,340,433,358,434,435,307,308,436,437,077,078,438,185,439,122,440,113,242,173,035,036,441,172,025,026,163,164,442,443,444,445,446,143,201,447,448,194,195,278,279,203,449,450,298,183,184,451,452,453,454,455,223,224,456,457,072,073,349,350,458,226,459,460,215,461,480,481,482,483,484,490]
            return subtractArray(input: input)
        } else if clType == 11 {
            let input =   [387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,063,064,065,129,130,406,315,407,041,042,169,074,075,076,095,208,408,409,410,411,066,067,068,054,055,412,412,412,413,413,413,414,265,266,267,268,269,415,416,417,418,419,420,421,422,422,423,423,214,190,424,425,426,427,428,092,093,094,200,429,198,430,431,432,118,119,339,340,433,358,434,435,307,308,436,437,077,078,438,185,439,122,440,113,242,173,035,036,441,172,025,026,163,164,442,443,444,445,446,143,201,447,448,194,195,278,279,203,449,450,298,183,184,451,452,453,454,455,223,224,456,457,072,073,349,350,458,226,459,460,215,461,480,481,482,483,484,490,479,479,479,479,479,479,207,472,299,476,280,281,282,475,108,463,133,134,135,136,196,197,470,471,333,334,175,176,468,228,229,081,082,462,114,465,193,469,357,111,112,464,355,356,477,137,233,474,123,212,239,125,466,240,126,467,220,221,473,361,362,478,359,487]
            return subtractArray(input: input)
        } else if clType == 12 {
            return Array(0..<251)
        } else if clType == 13 {
            let input = [494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,542,543,544,545,546,547,548,549,550,550,551,552,553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,592,593,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,639,640,641,642,643,644,645,646,647,648,648,649]
            return subtractArray(input: input)
        } else if clType == 14 {
            let input = [494,495,496,497,498,499,500,501,502,503,504,505,509,510,519,520,521,521,540,541,542,191,192,506,507,508,179,180,181,054,055,298,183,184,447,448,206,531,511,512,513,514,515,516,543,544,545,109,110,081,082,462,058,059,240,126,467,239,125,466,019,020,041,042,169,088,089,527,528,524,525,526,095,208,532,533,534,529,530,300,301,427,428,546,547,548,549,517,518,173,035,036,133,134,135,136,196,197,470,471,551,552,553,554,555,550,550,568,569,572,573,627,628,629,630,027,028,557,558,559,560,556,561,328,329,330,562,563,564,565,566,567,599,600,601,406,315,407,574,575,576,577,578,579,415,416,587,214,127,522,523,418,419,570,571,580,581,588,589,616,617,585,586,590,591,351,299,476,304,305,306,343,344,636,637,595,596,597,598,602,603,604,592,592,593,593,594,610,611,612,335,336,605,606,607,608,609,631,632,613,614,615,641,641,642,642,645,645,451,452,227,322,323,325,326,425,426,353,354,278,279,337,338,359,114,465,619,620,207,472,624,625,638,639,640,535,536,537,618,213,458,226,223,224,222,120,121,320,321,131,363,364,365,333,334,037,038,436,437,215,461,225,582,583,584,220,221,473,132,374,375,376,086,087,538,539,626,621,622,623,633,634,635,287,288,289,341,342,174,039,040,108,463,193,469,357,455,453,454,246,247,248,643,644,646,646,646,647,647,648,648,649]
            return subtractArray(input: input)
        } else if clType == 15 {
            let input = [650,651,652,653,654,655,656,657,658,659,660,263,264,661,662,663,016,017,018,664,665,666,010,011,012,013,014,015,511,512,513,514,515,516,172,025,026,399,400,206,298,183,184,412,412,412,413,413,413,414,283,284,129,130,341,342,118,119,318,319,667,668,054,055,083,447,448,280,281,282,475,669,670,671,406,315,407,165,166,415,416,300,301,001,002,003,004,005,006,007,008,009,672,673,674,675,676,084,085,311,312,316,317,559,560,063,064,065,043,044,045,182,161,162,290,291,292,677,678,352,679,680,681,543,544,545,531,235,453,454,580,581,682,683,684,685,313,314,187,188,189,446,143,293,294,295,307,308,041,042,169,610,611,612,719,720,721,425,426,619,620,335,336,325,326,359,686,687,337,338,371,372,373,278,279,276,277,688,689,557,558,072,073,320,321,370,690,691,692,693,120,121,090,091,211,116,117,230,369,551,552,553,694,695,449,450,111,112,464,095,208,527,528,066,067,068,104,105,115,303,696,697,698,699,142,597,598,209,210,309,310,228,229,133,134,135,136,196,197,470,471,700,587,193,469,701,561,622,623,299,476,296,297,538,539,396,397,398,434,435,029,030,031,032,033,034,702,433,358,439,122,577,578,579,360,202,524,525,526,302,703,128,241,179,180,181,127,214,417,079,080,199,102,103,441,458,226,366,367,368,223,224,222,170,171,594,131,144,145,146,050,051,328,329,330,443,444,445,074,075,076,218,219,213,451,452,194,195,704,705,706,588,589,616,617,069,070,071,455,092,093,094,060,061,062,186,023,024,618,339,340,509,510,261,262,504,505,624,625,707,430,590,591,270,271,272,418,419,550,708,709,710,711,607,608,609,479,081,082,462,100,101,568,569,220,221,473,712,713,613,614,238,124,582,583,584,459,460,225,215,461,532,533,534,324,027,028,304,305,306,246,247,248,631,632,167,168,021,022,615,227,714,715,207,472,163,164,174,039,040,353,354,570,571,574,575,576,438,185,327,216,217,108,463,123,212,132,333,334,621,633,634,635,147,148,149,716,717,718,150]
            return subtractArray(input: input)
        } else if clType == 16 {
            let input = [252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,475,283,284,285,286,287,288,289,063,064,065,290,291,292,293,294,295,296,297,118,119,129,130,298,183,184,074,075,076,299,476,300,301,041,042,169,072,073,302,303,304,305,306,066,067,068,307,308,309,310,311,312,081,082,462,100,101,313,314,043,044,045,182,084,085,406,315,407,316,317,318,319,320,321,322,323,218,219,324,088,089,109,110,325,326,027,028,327,227,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,174,039,040,349,350,351,120,121,352,353,354,355,356,477,357,433,358,359,037,038,172,025,026,054,055,360,202,177,178,203,231,232,127,214,111,112,464,361,362,478,363,364,365,366,367,368,369,222,170,171,370,116,117,230,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386]
            return subtractArray(input: input)
        } else if clType == 17 {
            let input = [722,723,724,725,726,727,728,729,730,731,732,733,734,735,019,020,010,011,012,165,166,167,168,172,025,026,736,737,738,438,185,440,113,242,446,143,079,080,199,278,279,063,064,065,052,053,081,082,462,088,089,058,059,096,097,296,297,235,739,740,092,093,094,425,426,200,429,041,042,169,050,051,021,022,627,628,629,630,056,057,225,741,742,743,548,549,546,547,054,055,129,130,339,340,066,067,068,524,525,526,703,302,744,745,327,072,073,456,457,746,370,222,747,748,090,091,371,372,373,506,507,508,133,134,135,136,196,197,470,471,700,749,750,174,039,040,128,241,283,284,751,752,753,754,755,756,046,047,060,061,062,186,118,119,349,350,594,661,662,663,757,758,104,105,115,240,126,467,759,760,761,762,763,764,127,765,766,704,705,706,351,767,768,120,121,769,770,408,409,410,411,566,567,564,565,708,709,299,476,771,170,171,772,773,718,568,569,227,132,173,035,036,774,374,375,376,137,233,474,674,675,775,324,776,777,239,125,466,074,075,076,551,552,553,328,329,330,443,444,445,707,778,779,780,359,361,362,478,215,461,027,028,037,038,582,583,584,209,210,422,423,369,781,318,319,320,321,131,102,103,782,783,784,587,123,212,198,430,447,448,147,148,149,142,785,786,787,788,789,790,791,792,793,794,795,796,797,798,799,800,801,802]
            return subtractArray(input: input)
        } else if clType == 18 {
            let input = [722,723,724,725,726,727,728,729,730,731,732,733,734,735,019,020,010,011,012,165,166,167,168,427,428,686,687,570,571,676,172,025,026,736,737,738,438,185,440,113,242,446,143,079,080,199,278,279,063,064,065,052,053,081,082,462,088,089,439,122,023,024,206,058,059,096,097,296,297,235,739,740,092,093,094,425,426,198,430,041,042,169,714,715,050,051,021,022,627,628,629,630,056,057,225,701,741,741,741,741,742,743,669,670,671,548,549,546,547,054,055,238,124,129,130,339,340,086,087,066,067,068,524,525,526,703,302,303,744,745,327,072,073,456,457,746,370,222,747,748,090,091,366,367,368,223,224,458,226,371,372,373,506,507,508,133,134,135,136,196,197,470,471,700,179,180,181,749,750,174,039,040,128,241,283,284,751,752,753,754,755,756,046,047,060,061,062,186,118,119,550,349,350,594,661,662,663,757,758,104,105,115,240,126,467,636,637,759,760,761,762,763,764,127,163,164,352,765,766,704,705,706,351,767,768,120,121,769,770,138,139,140,141,345,346,347,348,408,409,410,411,566,567,564,565,696,697,698,699,246,247,248,708,709,177,178,299,476,771,170,171,772,773,803,804,718,568,569,572,573,204,205,227,132,173,035,036,605,606,774,374,375,376,137,233,474,674,675,775,324,776,228,229,702,777,309,310,239,125,466,074,075,076,551,552,553,328,329,330,443,444,445,343,344,622,623,707,778,353,354,592,593,779,780,359,361,362,478,215,461,027,028,037,038,582,583,584,559,560,624,625,209,210,422,423,369,781,318,319,690,691,692,693,320,321,131,357,102,103,341,342,619,620,782,783,784,587,123,212,214,190,424,667,668,200,429,621,108,463,447,448,147,148,149,142,785,786,787,788,789,790,791,792,793,805,806,794,795,796,797,798,799,800,801,802,807]
            return subtractArray(input: input)
        }
        
        return Array(0...1)
    }
    
    func subtractArray(input: [Int]) -> [Int] {
        var output = input
        for j in 0..<output.count {
            output[j] = input[j] - 1
        }
        
        return output
    }
}