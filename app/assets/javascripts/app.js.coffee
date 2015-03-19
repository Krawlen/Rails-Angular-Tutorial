receta = angular.module('receta', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

receta.config(['$routeProvider', 'flashProvider',
  ($routeProvider, flashProvider)->
    $routeProvider
    .when('/',
      templateUrl: "index.html"
      controller: 'RecipesListController'
    ).when('/recipes/new',
      templateUrl: "form.html"
      controller: 'RecipeDetailController'
    ).when('/recipes/:recipeId',
      templateUrl: "show.html"
      controller: 'RecipeDetailController'
    ).when('/recipes/:recipeId/edit',
      templateUrl: "form.html"
      controller: 'RecipeDetailController'
    )

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")
])

controllers = angular.module('controllers', [])
