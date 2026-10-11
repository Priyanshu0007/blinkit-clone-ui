import Foundation

struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let flag: String
    let dialCode: String
    let code: String
}

extension Country {
    static let defaultCountry = Country(name: "India", flag: "🇮🇳", dialCode: "+91", code: "IN")

    static let allCountries: [Country] = [
        Country(name: "India", flag: "🇮🇳", dialCode: "+91", code: "IN"),
        Country(name: "Afganistan", flag: "🇦🇫", dialCode: "+93", code: "AF"),
        Country(name: "Albania", flag: "🇦🇱", dialCode: "+355", code: "AL"),
        Country(name: "Algeria", flag: "🇩🇿", dialCode: "+213", code: "DZ"),
        Country(name: "Andorra", flag: "🇦🇩", dialCode: "+376", code: "AD"),
        Country(name: "Antigua and Barbuda", flag: "🇦🇬", dialCode: "+1", code: "AG"),
        Country(name: "Argentina", flag: "🇦🇷", dialCode: "+54", code: "AR"),
        Country(name: "Armenia", flag: "🇦🇲", dialCode: "+374", code: "AM"),
        Country(name: "Australia", flag: "🇦🇺", dialCode: "+61", code: "AU"),
        Country(name: "Austria", flag: "🇦🇹", dialCode: "+43", code: "AT"),
        Country(name: "Azerbaijan", flag: "🇦🇿", dialCode: "+994", code: "AZ"),
        Country(name: "Bahamas", flag: "🇧🇸", dialCode: "+1", code: "BS"),
        Country(name: "Bahrain", flag: "🇧🇭", dialCode: "+973", code: "BH"),
        Country(name: "Bangladesh", flag: "🇧🇩", dialCode: "+880", code: "BD"),
        Country(name: "Belarus", flag: "🇧🇾", dialCode: "+375", code: "BY"),
        Country(name: "Belgium", flag: "🇧🇪", dialCode: "+32", code: "BE"),
        Country(name: "Bhutan", flag: "🇧🇹", dialCode: "+975", code: "BT"),
        Country(name: "Brazil", flag: "🇧🇷", dialCode: "+55", code: "BR"),
        Country(name: "Canada", flag: "🇨🇦", dialCode: "+1", code: "CA"),
        Country(name: "Cyprus", flag: "🇨🇾", dialCode: "+357", code: "CY"),
        Country(name: "Denmark", flag: "🇩🇰", dialCode: "+45", code: "DK"),
        Country(name: "Egypt", flag: "🇪🇬", dialCode: "+20", code: "EG"),
        Country(name: "France", flag: "🇫🇷", dialCode: "+33", code: "FR"),
        Country(name: "Germany", flag: "🇩🇪", dialCode: "+49", code: "DE"),
        Country(name: "Indonesia", flag: "🇮🇩", dialCode: "+62", code: "ID"),
        Country(name: "Ireland", flag: "🇮🇪", dialCode: "+353", code: "IE"),
        Country(name: "Italy", flag: "🇮🇹", dialCode: "+39", code: "IT"),
        Country(name: "Japan", flag: "🇯🇵", dialCode: "+81", code: "JP"),
        Country(name: "Malaysia", flag: "🇲🇾", dialCode: "+60", code: "MY"),
        Country(name: "Mauritius", flag: "🇲🇺", dialCode: "+230", code: "MU"),
        Country(name: "Mexico", flag: "🇲🇽", dialCode: "+52", code: "MX"),
        Country(name: "Nepal", flag: "🇳🇵", dialCode: "+977", code: "NP"),
        Country(name: "Netherlands", flag: "🇳🇱", dialCode: "+31", code: "NL"),
        Country(name: "New Zealand", flag: "🇳🇿", dialCode: "+64", code: "NZ"),
        Country(name: "Oman", flag: "🇴🇲", dialCode: "+968", code: "OM"),
        Country(name: "Qatar", flag: "🇶🇦", dialCode: "+974", code: "QA"),
        Country(name: "Saudi Arabia", flag: "🇸🇦", dialCode: "+966", code: "SA"),
        Country(name: "Singapore", flag: "🇸🇬", dialCode: "+65", code: "SG"),
        Country(name: "South Africa", flag: "🇿🇦", dialCode: "+27", code: "ZA"),
        Country(name: "Spain", flag: "🇪🇸", dialCode: "+34", code: "ES"),
        Country(name: "Sri Lanka", flag: "🇱🇰", dialCode: "+94", code: "LK"),
        Country(name: "Switzerland", flag: "🇨🇭", dialCode: "+41", code: "CH"),
        Country(name: "Thailand", flag: "🇹🇭", dialCode: "+66", code: "TH"),
        Country(name: "United Arab Emirates", flag: "🇦🇪", dialCode: "+971", code: "AE"),
        Country(name: "United Kingdom", flag: "🇬🇧", dialCode: "+44", code: "GB"),
        Country(name: "USA", flag: "🇺🇸", dialCode: "+1", code: "US")
    ]
}
