receta = angular.module('receta', [
  'templates',
  'ui.router',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

receta.config(['$stateProvider', '$urlRouterProvider', 'flashProvider',
  ($stateProvider, $urlRouterProvider, flashProvider)->
    $urlRouterProvider.otherwise '/recipes'

    $stateProvider.state('recipes',
      url: '/recipes'
      abstract: true
      template: '<ui-view/>')
    .state('recipes.list',
      url: '/?keywords'
      templateUrl: 'index.html'
      controller: 'RecipesListController'
    ).state('recipes.detail',
      url: '/{recipeId:int}'
      templateUrl: 'show.html',
      controller: 'RecipeDetailController')
    .state 'recipes.new',
      url: '/new'
      templateUrl: 'form.html'
      controller: 'RecipeDetailController'
    .state 'recipes.edit',
      url: '/:recipeId/edit'
      templateUrl: 'form.html'
      controller: 'RecipeDetailController'

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")
])

controllers = angular.module('controllers', [])
