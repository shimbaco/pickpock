module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: 'coffee'
      sass:
        files: ['src/scss/**/*.scss']
        tasks: 'sass'
    coffee:
      compile:
        files: [
          expand: true
          cwd: 'src/coffee'
          src: ['**/*.coffee']
          dest: 'app/js/'
          ext: '.js'
        ]
    sass:
      dist:
        files: [
          expand: true
          cwd: 'src/scss'
          src: ['**/*.scss']
          dest: 'app/css/'
          ext: '.css'
        ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.registerTask 'default', ['watch']
  return
