@usuarios
Feature: GET /usuarios - Listar usuarios registrados
  Como administrador del sistema
  Quiero listar los usuarios registrados
  Para consultar la información almacenada en la API

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'

  @parametrizado
  Scenario Outline: Listar usuarios usando filtros - <caso>
    * def rawQuery = { nome: '<nome>', email: '<email>', administrador: '<administrador>' }
    * def query    = karate.filterKeys(rawQuery, x => x.value != '')

    Given path '/usuarios'
    And   params query
    When  method GET
    Then  status 200
    And   match response.quantidade == '#number'
    And   match response.usuarios   == '#[]'

    Examples:
      | caso                      | nome            | email         | administrador |
      | listar todos los usuarios |                 |               |               |
      | filtrar por nombre        | Fulano da Silva |               |               |
      | filtrar por email         |                 | fulano@qa.com |               |
      | filtrar administradores   |                 |               | true          |