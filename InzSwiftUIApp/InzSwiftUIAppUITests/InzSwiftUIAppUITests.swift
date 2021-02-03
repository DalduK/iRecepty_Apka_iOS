//
//  InzSwiftUIAppUITests.swift
//  InzSwiftUIAppUITests
//
//  Created by Przemysław Woźny on 18/01/2021.
//

import XCTest

class InzSwiftUIAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }


    func test_username_typing() throws {
        let app = XCUIApplication()
        app.launch()
        
        let username = app.textFields["Nazwa użytkownika"]
        let password = app.secureTextFields["Hasło"]

        username.tap()
        username.typeText("daldek")

//        password.tap()
//        password.typeText("Haslo123$")
        
        XCTAssertEqual(username.value as! String, "daldek", "Text field value is not correct")
    }
    
    func test_login_without_good_password() throws {
        let app = XCUIApplication()
        app.launch()
        
        let username = app.textFields["Nazwa użytkownika"]
        let password = app.secureTextFields["Hasło"]
        let button = app.buttons["Zaloguj się"]

        
        password.tap()
        password.typeText("Haslo1234$")
        
        app.keyboards.buttons["Return"].tap()
        
        username.tap()
        username.typeText("daldek24")
        
        
        
        
        XCTAssertEqual(username.value as! String, "daldek24", "Text field value is not correct")
        XCTAssertEqual(password.value as! String, "•••••••••", "Text field value is not correct")
        
        button.tap()
        
        app.sheets["Nie istnieje taki użytkownik"].buttons["Potwierdź"].tap()
    }
    
    func test_login_with_good_password() throws {
        let app = XCUIApplication()
        app.launch()
        
        let username = app.textFields["Nazwa użytkownika"]
        let password = app.secureTextFields["Hasło"]
        let button = app.buttons["Zaloguj się"]

        
        password.tap()
        password.typeText("Haslo123$")
        
        app.keyboards.buttons["Return"].tap()
        
        username.tap()
        username.typeText("daldek24")
        
        
        
        
        XCTAssertEqual(username.value as! String, "daldek24", "Text field value is not correct")
        XCTAssertEqual(password.value as! String, "•••••••••", "Text field value is not correct")
        
        button.tap()
        
        sleep(5)
        
        let refresh = app.buttons["repeat.circle.fill"]
        
        refresh.tap()
        
    }
    
    func test_register_user_wrong_values() throws {
        let app = XCUIApplication()
        app.launch()
        
        let register_button = app.buttons["Utwórz konto"]
        register_button.tap()

        let imie = app.textFields["Imię"]
        let nazwisko = app.textFields["Nazwisko"]
        let username = app.textFields["Nazwa użytkownika"]
        let email = app.textFields["Email"]
        let pesel = app.textFields["Pesel"]
        let haslo = app.secureTextFields["Hasło"]
        let haslo2 = app.secureTextFields["Powtórz hasło"]
        
        let button = app.buttons["Zarejestruj się"]
        
        button.tap()

        app.sheets.firstMatch.buttons["Potwierdź"].tap()

        imie.tap()
        imie.typeText("Przemek")
        
        app.keyboards.buttons["Return"].tap()
        
        button.tap()
        
        app.sheets.firstMatch.buttons["Potwierdź"].tap()
        
        
        nazwisko.tap()
        nazwisko.typeText("Woźny")
        
        app.keyboards.buttons["Return"].tap()
        
        button.tap()
        
        app.sheets.firstMatch.buttons["Potwierdź"].tap()

        username.tap()
        username.typeText("daldek24")
        
        app.keyboards.buttons["Return"].tap()
        
        button.tap()
        
        app.sheets.firstMatch.buttons["Potwierdź"].tap()

        email.tap()
        email.typeText("email@email.com")
        
        app.keyboards.buttons["Return"].tap()
        
        button.tap()
        
        app.sheets.firstMatch.buttons["Potwierdź"].tap()

        pesel.tap()
        pesel.typeText("12121212121")
        
        app.firstMatch.buttons["Zamknij"].tap()
        
        button.tap()
        
        app.sheets.firstMatch.buttons["Potwierdź"].tap()

        haslo.tap()
        haslo.typeText("Haslo123$")
        
        app.keyboards.buttons["Return"].tap()
        
        button.tap()
        
        app.sheets.firstMatch.buttons["Potwierdź"].tap()

        haslo2.tap()
        haslo2.typeText("Haslo123$")
        
        app.keyboards.buttons["Return"].tap()
        
        button.tap()
        
        sleep(5)
        
        app.sheets.firstMatch.buttons["Potwierdź"].tap()
        
        
    }
    
    
    
    func test_register_user_good_values() throws {
        let app = XCUIApplication()
        app.launch()

        let register_button = app.buttons["Utwórz konto"]
        register_button.tap()

        let imie = app.textFields["Imię"]
        let nazwisko = app.textFields["Nazwisko"]
        let username = app.textFields["Nazwa użytkownika"]
        let email = app.textFields["Email"]
        let pesel = app.textFields["Pesel"]
        let haslo = app.secureTextFields["Hasło"]
        let haslo2 = app.secureTextFields["Powtórz hasło"]

        let reg = app.switches["reg"]

        let button = app.buttons["Zarejestruj się"]
        imie.tap()
        imie.typeText("Przemek")
        
        app.keyboards.buttons["Return"].tap()
        nazwisko.tap()
        nazwisko.typeText("Woźny")
        
        app.keyboards.buttons["Return"].tap()
        username.tap()
        username.typeText("daldek24")
        
        app.keyboards.buttons["Return"].tap()
        email.tap()
        email.typeText("dalduk141414@gmail.com")

        app.keyboards.buttons["Return"].tap()
        pesel.tap()
        pesel.typeText("12121212121")
        app.firstMatch.buttons["Zamknij"].tap()

        haslo.tap()
        haslo.typeText("Haslo123$")
        app.keyboards.buttons["Return"].tap()

        haslo2.tap()
        haslo2.typeText("Haslo123$")
        app.keyboards.buttons["Return"].tap()

        reg.tap()
        button.tap()
        sleep(15)
        
        app.firstMatch.buttons["Dalej"].tap()
        
    }
    

    func testLaunchPerformance() throws {
        if #available(iOS 14.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
