Feature: Validación del servicio Lobby Filter

Background:
    * url 'https://c03bd4ncki.execute-api.us-west-2.amazonaws.com/dev'
    * header Content-Type = 'application/json'

# CA.1 - Parámetro lobby obligatorio
Scenario Outline: Validar que el campo lobby es obligatorio

    Given path 'lobbies/filter'
    And request
    """
    {
      "lobby": <lobby>
    }
    """
    When method post
    Then status <status>

Examples:
| lobby | status |
| "" | 400 |
| null | 400 |

# CA.7 - Respuesta exitosa
Scenario: Validar respuesta exitosa cuando el lobby es válido

    Given path 'lobbies/filter'
    And request
    """
    {
      "lobby": "Lobby Todos Los Juegos Desktop"
    }
    """
    When method post
    Then status 200
    And match response.success == true

# CA.8 - Tiempo máximo de respuesta
Scenario: Validar tiempo de respuesta menor o igual a 3 segundos

    Given path 'lobbies/filter'
    And request
    """
    {
      "lobby": "Lobby Todos Los Juegos Desktop"
    }
    """
    When method post
    Then status 200
    And assert responseTime <= 3000

    Scenario Outline: [102734] Validar envio de atributo "lobby" como valor de lobby existente
    * def responseBettingRangeItemsSchema =
      """
      {
        min: '#number',
        max: '#number'
      }
      """

    Given request { lobby: '<lobby>' }
    When method post
    Then status 200
    And match response.message == "Success"
    And assert response.data.length >= 1
    And match $response.data[*].key contains "bettingRange"

    * def bettingRangeList = karate.filter(response.data, function(x){ return x.key == 'bettingRange' })

    * def bettingRange = bettingRangeList[0]

    And match bettingRange.type == "range"
    And match bettingRange.items == responseBettingRangeItemsSchema

    Examples:
      |lobby                          |
      |Lobby Todos Los Juegos Desktop |
      |Lobby Progresivos Desktop      |
      |Lobby Clasicas Desktop         |
      |Lobby Compra Bonus Desktop     |
      |Lobby High Rollers Desktop     |
      |Lobby Nuevos Juegos Desktop    |
      |Lobby Mas Jugados Desktop      |
      |cineDesktop                    |
