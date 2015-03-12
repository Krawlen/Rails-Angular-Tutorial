describe "RecipesController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  # access injected service later
  httpBackend  = null

  setupController = (keywords,results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      # capture the injected service
      httpBackend = $httpBackend

      if results
        if keywords
          request = new RegExp("\/recipes.*keywords=#{keywords}")
        else
          request = new RegExp("\/recipes.*")
        httpBackend.expectGET(request).respond(results)

      ctrl = $controller('RecipesController',
        $scope: scope
        $location: location)
    )

  beforeEach(module("receta"))
  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()



  describe 'controller initialization', ->
    recipes = [
      {
        id: 1
        name: 'Baked Potato w/ Cheese'
      },
      {
        id: 2
        name: 'Garlic Mashed Potatoes',
      },
      {
        id: 3
        name: 'Potatoes Au Gratin',
      },
      {
        id: 4
        name: 'Baked Brussel Sprouts',
      },
    ]
    describe 'when no keywords present', ->
      beforeEach ->
        setupController('',recipes)
        httpBackend.flush()

      it 'defaults to all recipes', ->
        expect(scope.recipes).toEqualData(recipes)

    describe 'with keywords', ->
      keywords = 'foo'
      beforeEach ->
        setupController(keywords,recipes)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.recipes).toEqualData(recipes)

  describe 'search()', ->
    beforeEach ->

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqualData({keywords: keywords})