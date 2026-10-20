import UIKit

enum AppSettings {
    /// Product capabilities — keep aligned with the Android sibling demo.
    static let wantRecognition = false
    static let wantAuthenticity = true

    static func authenticityMode(licenseAllows: Bool) -> String {
        licenseAllows ? "normal" : "none"
    }
}

/// Session helper for document authenticity / liveness-only product.
/// Camera guide crops include margins — pass alreadyCropped=false so the engine
/// re-detects (Android CameraActivity). Gallery full-frame picks also use false.
enum DocSdkSession {
    @discardableResult
    static func startGallery() -> String {
        DocumentLivenessSDK.startNewSession("{\"scenario\":\"FullAuth\",\"series\":false}")
    }

    /// Authenticity / security only (no OCR).
    /// - Returns: (json, optional user-facing deny message)
    static func recognize(
        front: UIImage,
        back: UIImage? = nil,
        alreadyCropped: Bool = false
    ) -> (String, String?) {
        let status = LicenseStatus.current()
        let deny = status.denyMessage(
            wantRecognition: AppSettings.wantRecognition,
            wantAuthenticity: AppSettings.wantAuthenticity
        )
        startGallery()
        let json = DocumentLivenessSDK.documentLivenessFront(
            front,
            back: back,
            alreadyCropped: alreadyCropped
        )
        return (json, deny)
    }
}
