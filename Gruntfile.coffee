appFiles = ['app/**/*.coffee', '!app/public/**/*']
gruntFiles = 'Gruntfile.coffee'

module.exports = (grunt) ->
  grunt.initConfig
    options:
      destPrefix: 'app/public'
  
    bowercopy:
      options:
        clean: true
      bootstrap:
        files:
          'app/public/css': 'bower_components/bootstrap/dist/css'
          'app/public/fonts': 'bower_components/bootstrap/dist/fonts'
          'app/public/js': 'bower_components/bootstrap/dist/js'
      jquery:
        files:
          'app/public/js': 'bower_components/jquery/dist'
      
    coffeelint:
      options:
        configFile: 'coffeelint.json'
      grunt: gruntFiles
      app: appFiles
      
    watch:
      app:
        files: appFiles
        tasks: 'coffeelint:app'
      grunt:
        files: gruntFiles
        tasks: 'coffeelint:grunt'
      npm:
        files: 'package.json'
        tasks: 'npm-install'
  
  grunt.loadNpmTasks 'grunt-bowercopy'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-npm-install'
  