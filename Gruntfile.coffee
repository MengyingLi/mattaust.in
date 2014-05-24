appFiles = ['app/**/*.coffee', '!app/public/**/*']
gitHooks = 'git/hooks/*'
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
      
    copy:
      git:
        options:
          mode: '0755'
        src: gitHooks
        dest: '.git/hooks/'
        expand: true
        flatten: true
      
    watch:
      app:
        files: appFiles
        tasks: 'coffeelint:app'
      git:
        files: gitHooks
        tasks: 'copy:git'
      grunt:
        files: gruntFiles
        tasks: 'coffeelint:grunt'
      npm:
        files: 'package.json'
        tasks: 'npm-install'
  
  grunt.loadNpmTasks 'grunt-bowercopy'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-npm-install'
  
  grunt.registerTask 'lint', ['coffeelint']
  