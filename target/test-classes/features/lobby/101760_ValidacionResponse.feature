Feature: Validacion Response

  Background:
    * url 'https://c03bd4ncki.execute-api.us-west-2.amazonaws.com'
    * path '/dev/lobbies/filter'
    * header Content-Type = 'application/json'

  @Validacion_Response
  Scenario: [102219] Validar Tiempo de Respuesta
    Given request { lobby: 'Lobby Todos Los Juegos Desktop' }
    When method post
    Then status 200
    * print 'Tiempo Respuesta: ' + responseTime
    And match responseTime == '#? _ <= 3000'

  @Validacion_Response
  Scenario: [102223] Validar Estructura General del Response
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

    * def responseSchema =
      """
      {
        success: '#boolean',
        message: '#string',
        data: '#[] responseDataSchema'
      }
      """

    Given request { lobby: 'Lobby Todos Los Juegos Desktop' }
    When method post
    Then status 200
    And match response.message == "Success"
    And assert response.data.length >= 1
    And match response == responseSchema

  @Validacion_Response
  Scenario: [102224] Validar Orden del Response
    * def ordenAsc =
      """
      function(arr){
        if (!arr || arr.length < 2)
          return true;

        for (var i = 0; i < arr.length - 1; i++) {
          if (typeof arr[i] !== 'number' || typeof arr[i+1] !== 'number')
            return false;

          if (arr[i] >= arr[i+1])
            return false;
        }

        return true;
      }
      """

    Given request { lobby: 'Lobby Todos Los Juegos Desktop' }
    When method post
    Then status 200

    * def orders = $response.data[*].order

    And match ordenAsc(orders) == true