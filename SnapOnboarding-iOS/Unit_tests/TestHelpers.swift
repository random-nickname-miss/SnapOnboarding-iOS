import UIKit
import SnapTagsView
@testable import SnapOnboarding_iOS

private class SnapOnboardingDelegateExample: SnapOnboardingDelegate {

    func onboardingWillAppear() {}
    
    func termsAndConditionsTapped() {}
    func privacyPolicyTapped() {}
    
    func enableLocationServicesTapped() {}
    func locationServicesInstructionsTapped() {}
    
    func facebookSignupTapped() {}
    func instagramSignupTapped() {}
    func continueAsLoggedInUserTapped() {}
    func skipLoginTapped() {}
    func logoutFromCurrentAccountTapped() {}
    
}

func mockSnapOnboardingDelegate() -> SnapOnboardingDelegate {
    return SnapOnboardingDelegateExample()
}

func mockSnapOnboardingViewModelNorwegian() -> SnapOnboardingViewModel {
    var termsViewModel = SnapOnboardingViewModel.TermsViewModel()
    let footer = "Ved bruk av tjenesten Snapsale godtar du Vilkårene for bruk og Retningslinjer for personvern"
    termsViewModel.termsAndPrivacyFooter = footer
    termsViewModel.rangeOfTermsAndConditions = footer.range(of: "Vilkårene for bruk")
    termsViewModel.rangeOfPrivacyPolicy = footer.range(of: "Retningslinjer for personvern")

    var introViewModel = SnapOnboardingViewModel.IntroViewModel()
    introViewModel.next = "Neste"
    introViewModel.introHeadline = "Å legge ut salg er raskt og enkelt. Vi tagger og kategoriserer annonser med smart bildegjenkjenning."
    introViewModel.tags = createTagRepresentationsForStrings(
        ["Veske", "MichaelKors", "JetSetTravel", "Skinn", "Beige", "Accessoirer", "Møbler", "Jakke", "Elektronikk", "Dekorasjon", "Bøker", "Zara", "Solbriller", "Gant"]
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
    loginViewModel.welcomeBack = "Velkommen tilbake!"
    loginViewModel.continve = "Fortsett"
    loginViewModel.logInWithAnotherAccount = "Logg inn med en annen konto"

    let model = SnapOnboardingViewModel(
        termsViewModel: termsViewModel,
        introViewModel: introViewModel,
        locationViewModel: locationViewModel,
        loginViewModel: loginViewModel
    )

    return model
}

func mockSnapOnboardingViewModelEnglish() -> SnapOnboardingViewModel {
    var termsViewModel = SnapOnboardingViewModel.TermsViewModel()
    let footer = "You accept our Privacy Policy and Terms And Conditions by using the service Snapsale."
    termsViewModel.termsAndPrivacyFooter = footer
    termsViewModel.rangeOfTermsAndConditions = footer.range(of: "Terms And Conditions")
    termsViewModel.rangeOfPrivacyPolicy = footer.range(of: "Privacy Policy")

    var introViewModel = SnapOnboardingViewModel.IntroViewModel()
    introViewModel.next = "Next"
    introViewModel.introHeadline = "Publishing sales is fast and easy. We tag and categorize ads with clever image recognition."
    introViewModel.tags = createTagRepresentationsForStrings(
        ["Purse", "MichaelKors", "JetSetTravel", "Leather", "Beige", "Accessories", "Furniture", "Jacket", "Electronics", "Decorations", "Books", "Zara", "Sunglasses", "Gant"]
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
    loginViewModel.welcomeBack = "Welcome back!"
    loginViewModel.continve = "Continue"
    loginViewModel.logInWithAnotherAccount = "Log in with another account"

    let model = SnapOnboardingViewModel(
        termsViewModel: termsViewModel,
        introViewModel: introViewModel,
        locationViewModel: locationViewModel,
        loginViewModel: loginViewModel
    )

    return model
}

private func createTagRepresentationsForStrings(_ strings: [String]) -> [SnapTagRepresentation] {
    var snapTagRepresentations = [SnapTagRepresentation]()
    strings.forEach { tag in
        let tagRepresentation = SnapTagRepresentation(tag: tag)
        snapTagRepresentations.append(tagRepresentation)
    }
    return snapTagRepresentations
}

func getSnapOnboardingViewController() -> SnapOnboardingViewController {
    let storyboard = UIStoryboard(name: "SnapOnboarding", bundle: Bundle.main)
    return storyboard.instantiateViewController(withIdentifier: "SnapOnboardingViewController") as! SnapOnboardingViewController
}

func mockUserViewModel() -> UserViewModel {
    let userViewModel = UserViewModel(profileImageURL: nil)
    return userViewModel
}
