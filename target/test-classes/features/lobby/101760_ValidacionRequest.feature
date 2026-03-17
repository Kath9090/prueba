Feature: Validacion Request

  Background:
    * url 'https://c03bd4ncki.execute-api.us-west-2.amazonaws.com'
    * path '/dev/lobbies/filter'
    * header Content-Type = 'application/json'

  @Validacion_Request
  Scenario: [102208] Validar envio sin atributo "lobby"
    Given request {}
    When method post
    Then status 400
    And match response.message == "Completar los campos obligatorios"

  @Validacion_Request
  Scenario: [102209] Validar envio de atributo "lobby" como null
    Given request { lobby: null }
    When method post
    Then status 400
    And match response.message == "Completar los campos obligatorios"

  @Validacion_Request
  Scenario: [102210] Validar envio de atributo "lobby" como valor numerico
    Given request { lobby: 50 }
    When method post
    Then status 400
    And match response.message == "El parámetro 'lobby' no es válido"

  @Validacion_Request
  Scenario: [102211] Validar envio de atributo "lobby" como valor booleano
    Given request { lobby: true }
    When method post
    Then status 400
    And match response.message == "El parámetro 'lobby' no es válido"

  @Validacion_Request
  Scenario: [102212] Validar envio de atributo "lobby" como objeto
    Given request { lobby: { objeto: 'prueba' } }
    When method post
    Then status 400
    And match response.message == "El parámetro 'lobby' no es válido"

  @Validacion_Request
  Scenario: [102213] Validar envio de atributo "lobby" como array
    Given request { lobby: { array: ['prueba', 'test'] } }
    When method post
    Then status 400
    And match response.message == "El parámetro 'lobby' no es válido"

  @Validacion_Request
  Scenario: [102214] Validar envio de atributo "lobby" como vacio
    Given request { lobby: '' }
    When method post
    Then status 400

  @Validacion_Request
  Scenario: [102215] Validar envio de atributo "lobby" como espacios ("  ")
    Given request { lobby: ' ' }
    When method post
    Then status 400

  @Validacion_Request
  Scenario: [102216] Validar envio de atributo "lobby" como texto entre espacios (" texto ")
    Given request { lobby: ' Lobby Todos Los Juegos Desktop ' }
    When method post
    Then status 200
    And match response.message == "Success"
    And assert response.data.length >= 1

  @Validacion_Request
  Scenario: [102222] Validar envio de atributo "lobby" como emoji
    Given request { lobby: '😀' }
    When method post
    Then status 400
    And match response.message == "El parámetro 'lobby' no es válido"

  @Validacion_Request
  Scenario Outline: [102217] Validar envio de atributo "lobby" como valor de lobby existente
    * def responseItemsSchema =
    """
    {
      key: '#string',
      value: '#string',
      enabled: '#boolean'
    }
    """

    * def responseDataSchema =
    """
    {
      key: '#string',
      order: '#number',
      items: '#[] responseItemsSchema'
    }
    """

    * def expectedKeys = ['paymentMechanics','jackpotTypes','attractions','themes','volatilities']

    Given request { lobby: '<lobby>' }
    When method post
    Then status 200
    And match response.message == "Success"
    And assert response.data.length >= 1
    And match each response.data == responseDataSchema
    And match $response.data[*].key contains only expectedKeys

  Examples:
    |lobby                          |
    |Lobby Todos Los Juegos Desktop |
    |Lobby Progresivos Desktop      |
    |Lobby Clasicas Desktop         |
    |Lobby Compra Bonus Desktop     |
    |Lobby High Rollers Desktop     |
    #|juegoscrashdesktop             |
    |Lobby Todos Los Juegos Desktop |
    |Lobby Nuevos Juegos Desktop    |
    |Lobby Mas Jugados Desktop      |
    |cineDesktop                    |

  @Validacion_Request
  Scenario: [102218] Validar envio de atributo "lobby" como valor de lobby inexistente
    * def responseDataSchema =
      """
      {
        key: '#string',
        order: '#number',
        items: '#[]'
      }
      """

    Given request { lobby: 'Lobby Fake' }
    When method post
    Then status 200
    And match response.message == "Success"
    And assert response.data.length >= 1
    And match each response.data == responseDataSchema