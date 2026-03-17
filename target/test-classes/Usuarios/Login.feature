@login
Feature: POST /login - Autenticación de usuario
  Como usuario del sistema
  Quiero autenticarme mediante el endpoint /login
  Para obtener un token de acceso

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'

  @happy @smoke
  Scenario: Login exitoso con credenciales válidas
    # Paso 1: Crear usuario dinámico para garantizar que existe
    * def email = 'login_' + java.lang.System.currentTimeMillis() + '@qa.com'
    Given path '/usuarios'
    And request
      """
      {
        "nome":          "Login Test",
        "email":         "#(email)",
        "password":      "teste123",
        "administrador": "true"
      }
      """
    When method POST
    Then status 201

    # Paso 2: Login con ese usuario
    Given path '/login'
    And request { email: '#(email)', password: 'teste123' }
    When method POST
    Then status 200
    And match response == { message: '#string', authorization: '#string' }
    And match response.message       == 'Login realizado com sucesso'
    And match response.authorization == '#? _.startsWith("Bearer ")'

  @validacion
  Scenario: Login sin email devuelve 400
    Given path '/login'
    And request { password: "teste123" }
    When method POST
    Then status 400
    And match response.email == '#string'

  @validacion
  Scenario: Login sin password devuelve 400
    Given path '/login'
    And request { email: "fulano@qa.com" }
    When method POST
    Then status 400
    And match response.password == '#string'

  @auth
  Scenario: Login con password incorrecto devuelve 401
    Given path '/login'
    And request
      """
      {
        "email":    "fulano@qa.com",
        "password": "123456"
      }
      """
    When method POST
    Then status 401
    And match response.message == "Email e/ou senha inválidos"

  @parametrizado
  Scenario Outline: Login con credenciales inválidas — <caso>
    Given path '/login'
    And request
      """
      {
        "email":    "<email>",
        "password": "<password>"
      }
      """
    When method POST
    Then status 401
    And match response.message == "Email e/ou senha inválidos"

    Examples:
      | caso                | email          | password  |
      | email inexistente   | ghost@test.com | teste123  |
      | password incorrecto | fulano@qa.com  | wrongpass |
      | ambos incorrectos   | fake@fake.com  | fake123   |

  @flujo @e2e
  Scenario: Usar token obtenido para acceder a endpoint protegido
    # Paso 1: Crear usuario dinámico
    * def email = 'e2e_' + java.lang.System.currentTimeMillis() + '@qa.com'
    Given path '/usuarios'
    And request
      """
      {
        "nome":          "E2E Token Test",
        "email":         "#(email)",
        "password":      "teste123",
        "administrador": "true"
      }
      """
    When method POST
    Then status 201

    # Paso 2: Login y captura del token
    Given path '/login'
    And request
      """
      {
        "email":    "#(email)",
        "password": "teste123"
      }
      """
    When method POST
    Then status 200
    And match response.authorization == '#? _.startsWith("Bearer ")'
    * def token = response.authorization

    # Paso 3: Usar el token en endpoint protegido
    Given url 'https://serverest.dev'
    And path '/carrinhos'
    And header Authorization = token
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.carrinhos  == '#[] #object'







    
 



 