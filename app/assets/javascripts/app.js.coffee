receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
])

receta.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
    .when('/',
      templateUrl: "index.html"
      controller: 'RecipesController'
    )
])

controllers = angular.module('controllers',[])
controllers.controller("RecipesController", [ '$scope', '$routeParams', '$location','$resource'
  ($scope,$routeParams,$location, $resource)->
    Recipe = $resource('/recipes/:recipeId', { recipeId: "@id", format: 'json' })

    $scope.search = (keywords)->
      $location.path("/").search('keywords',keywords)

    if $routeParams.keywords
      Recipe.query(keywords: $routeParams.keywords, (results)-> $scope.recipes = results)
    else
      $scope.recipes = Recipe.query({}, (results)-> $scope.recipes = results)
])