import UIKit
import SnapFonts_iOS
import SnapTagsView
import SnapOnboarding_iOS

class ViewController: UIViewController {
    
    private var onboardingViewController: SnapOnboardingViewController?
    
    private var didPresent = false
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !didPresent {
            didPresent = true
            presentOnboardingViewController()
        }
    }
    
    private func presentOnboardingViewController() {
        let podBundle = NSBundle(forClass: SnapOnboardingViewController.self)
        let storyboard = UIStoryboard(name: "SnapOnboarding", bundle: podBundle)
        onboardingViewController = storyboard.instantiateViewControllerWithIdentifier("snapOnboardingViewController") as? SnapOnboardingViewController
        
        let viewModel = createSampleViewModelNorwegian()
//        let viewModel = createSampleViewModelEnglish()
        let configuration = SnapOnboardingConfiguration(delegate: self, viewModel: viewModel)
        
        onboardingViewController?.applyConfiguration(configuration)
        presentViewController(onboardingViewController!, animated: false, completion: nil)
    }
    
    func createSampleViewModelNorwegian() -> SnapOnboardingViewModel {
        var termsViewModel = SnapOnboardingViewModel.TermsViewModel()
        let footer = "Ved bruk av tjenesten Snapsale godtar du Vilkårene for bruk og Retningslinjer for personvern"
        termsViewModel.termsAndPrivacyFooter = footer
        termsViewModel.rangeOfTermsAndConditions = footer.rangeOfString("Vilkårene for bruk")
        termsViewModel.rangeOfPrivacyPolicy = footer.rangeOfString("Retningslinjer for personvern")
        
        var introViewModel = SnapOnboardingViewModel.IntroViewModel()
        introViewModel.next = "Neste"
        introViewModel.introHeadline = "Å legge ut salg er raskt og enkelt. Vi tagger og kategoriserer annonser med smart bildegjenkjenning."
        introViewModel.tags = createTagRepresentationsForStrings(
            ["Veske", "MichaelKors", "JetSetTravel", "Skinn", "Beige", "Accessoirer", "MØBLER", "JAKKE", "ELEKTRONIKK", "DEKORASJON", "BØKER", "ZARA", "SOLBRILLER", "GANT"]
        )
        
        var locationViewModel = SnapOnboardingViewModel.LocationViewModel()
        locationViewModel.next = "Neste"
        locationViewModel.locationHeadline = "Følg selgere og produkter nær deg! Aldri gå glipp av et kupp igjen."
        locationViewModel.enableLocationServices = "Skru på stedstjenester"
        locationViewModel.notNow = "Ikke nå"
        locationViewModel.willAskLaterTitle = "Den er god!"
        locationViewModel.willAskLaterBody = "Vi vil spørre deg på et senere tidspunkt, når vi trenger lokasjonen din, for eksempel ved et nytt salg."
        locationViewModel.wowYouDeclinedTitle = "Oi, du avslo stedstjenester!"
        locationViewModel.wowYouDeclinedBody = "Om du ønsker å skru det på senere, gå til: System-innstillinger › Personvern › Stedstjenester › Snapsale"
        locationViewModel.didEnableLocationServicesTitle = "Takk!"
        locationViewModel.didEnableLocationServicesBody = "Du skrudde på stedstjenester, og får derfor maksimalt utbytte av tjenesten."
        
        var loginViewModel = SnapOnboardingViewModel.LoginViewModel()
        loginViewModel.continueWithFacebook = "Fortsett med Facebook"
        loginViewModel.continueWithInstagram = "Fortsett med Instagram"
        loginViewModel.skipWithoutLogin = "Hopp over, prøve uten innlogging"
        
        let model = SnapOnboardingViewModel(
            termsViewModel: termsViewModel,
            introViewModel: introViewModel,
            locationViewModel: locationViewModel,
            loginViewModel: loginViewModel
        )
        
        return model
    }
    
    func createSampleViewModelEnglish() -> SnapOnboardingViewModel {
        var termsViewModel = SnapOnboardingViewModel.TermsViewModel()
        let footer = "You accept our Privacy Policy and Terms And Conditions by using the service Snapsale."
        termsViewModel.termsAndPrivacyFooter = footer
        termsViewModel.rangeOfTermsAndConditions = footer.rangeOfString("Terms And Conditions")
        termsViewModel.rangeOfPrivacyPolicy = footer.rangeOfString("Privacy Policy")
        
        var introViewModel = SnapOnboardingViewModel.IntroViewModel()
        introViewModel.next = "Next"
        introViewModel.introHeadline = "Publishing sales is fast and easy. We tag and categorize ads with clever image recognition."
        introViewModel.tags = createTagRepresentationsForStrings(
            ["Purse", "MichaelKors", "JetSetTravel", "Leather", "Beige", "Accessories", "FURNITURE", "JACKET", "ELECTRONICS", "DECORATIONS", "BOOKS", "ZARA", "SUNGLASSES", "GANT"]
        )
        
        var locationViewModel = SnapOnboardingViewModel.LocationViewModel()
        locationViewModel.next = "Next"
        locationViewModel.locationHeadline = "Follow sellers and products near you! Never miss a bargain again."
        locationViewModel.enableLocationServices = "Enable location services"
        locationViewModel.notNow = "Not now"
        locationViewModel.willAskLaterTitle = "All right!"
        locationViewModel.willAskLaterBody = "We will ask again later, when we need your location, for instance when you publish an ad."
        locationViewModel.wowYouDeclinedTitle = "Wow, you disabled location services!"
        locationViewModel.wowYouDeclinedBody = "If you wish to enable it later, navigate to: System settings › Privacy › Location Services › Snapsale."
        locationViewModel.didEnableLocationServicesTitle = "Thank you!"
        locationViewModel.didEnableLocationServicesBody = "You enabled location services, and will therefore get the most of the service."
        
        var loginViewModel = SnapOnboardingViewModel.LoginViewModel()
        loginViewModel.continueWithFacebook = "Continue with Facebook"
        loginViewModel.continueWithInstagram = "Continue with Instagram"
        loginViewModel.skipWithoutLogin = "Skip, try without logging in"
        
        let model = SnapOnboardingViewModel(
            termsViewModel: termsViewModel,
            introViewModel: introViewModel,
            locationViewModel: locationViewModel,
            loginViewModel: loginViewModel
        )
        
        return model
    }
    
    private func createTagRepresentationsForStrings(strings: [String]) -> [SnapTagRepresentation] {
        var snapTagRepresentations = [SnapTagRepresentation]()
        strings.forEach { tag in
            let tagRepresentation = SnapTagRepresentation()
            tagRepresentation.tag = tag
            snapTagRepresentations.append(tagRepresentation)
        }
        return snapTagRepresentations
    }

}

extension ViewController: SnapOnboardingDelegate {
    
    func termsAndConditionsTapped() {
        print("terms-and-conditions-tapped")
    }
    
    func privacyPolicyTapped() {
        print("privacy-policy-tapped")
    }
    
    
    func enableLocationServicesTapped() {
        print("enable-location-services-tapped")
        
        let alertController = UIAlertController(
            title: "Vil du gi «Snapsale» tilgang til plasseringen din når du bruker appen?",
            message: "Snapsale trenger din posisjon for å beregne avstand til salg",
            preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Ikke tillat", style: .Default, handler: { _ in
            self.onboardingViewController?.locationServicesStatusChanged(false)
        }))
        alertController.addAction(UIAlertAction(title: "Tillat", style: .Default, handler: { _ in
            self.onboardingViewController?.locationServicesStatusChanged(true)
        }))
        
        onboardingViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func facebookSignupTapped() {
        print("facebook-signup-tapped")
    }
    
    func instagramSignupTapped() {
        print("instagram-signup-tapped")
    }
    
    
    func willDismiss() {
        print("will-dismiss")
    }
    
    func didDismiss() {
        print("did-dismiss")
    }
    
}