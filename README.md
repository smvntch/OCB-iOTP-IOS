# OCBiOTP app
OCBiOTP app

### Config URL

1. Open `GlobalVars.swift` and navigate to URL Config mark
```
// MARK: - URL Config
static let baseUrl = "https://your_auth_url"
```

2. To config trusted certificates, open `Utility.swift` and replace your own certificate at `Utility.initSDK()` function