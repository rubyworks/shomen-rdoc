module Shomen

  module Rdoc

    # TODO: Instead of using command line options for shomen
    # we could use environment variables. ?

    # The Shomen RDoc command line tool provides a utility to generate
    # a Shomen documentation file using RDoc's .rdoc cache.
    #
    # Examples:
    #
    #     $ shomen-rdoc --readme README.md lib - [A-Z]*.*
    #
    class Command
      require 'optparse'

      # Public: Shortcut for `CLI.new(*argv).run`.
      #
      # Returns nothing.
      def self.run(*argv)
        new(*argv).run
      end

      # Command line options.
      attr :options

      # Initialize new command.
      #
      # argv - Command line arguments. [Array]
      #
      # Returns CLI instance.
      def initialize(*argv)
        @options = {}

        parse(argv)
      end

      # Public: Run command.
      #
      # Returns nothing.
      def run
        generator = Generator.new(options)
        $stdout.puts generator
      end

      # Parse command line arguments.
      #
      # argv - List of command line arguments. [Array]
      #
      # Returns list of arguments. [Array]
      #
      def parse(argv)
        if i = argv.index('-')
          options[:documents] = argv[i+1..-1]
          argv = argv[0...i]
        end

        parser = OptionParser.new
        parser_options(parser)
        parser.parse!(argv)

        if !(force? or root?)
          $stderr.puts "ERROR: Not a project directory. Use --force to override."
          exit -1
        end

        options[:scripts] = argv
      end

      # Define command line options.
      #
      # parser - Instance of {OptionParser}.
      #
      # Returns nothing.
      def parser_options(parser)
        parser.on('-j', '--json', 'output JSON instead of YAML (default)') do
          options[:format] = :json
        end
        parser.on('-y', '--yaml', 'output YAML instead of JSON') do
          options[:format] = :yaml
        end

        parser.on('-d', '--db DIR', 'documentation store directory (deafult is `.rdoc` or `.yardoc`)') do |dir|
          options[:store] = dir
        end
        parser.on('-c', '--use-cache', 'do not regenerate docs, use pre-existing cache') do
          options[:use_cache] = true
        end

        parser.on('-s', '--source', 'include full source in script documentation') do
          options[:source] = true
        end
        parser.on('-w', '--webcvs URI', 'prefix link to source code') do |uri|
          options[:webcvs] = uri
        end
        parser.on('-r', '--readme FILE', 'which file to use as main') do |file|
          options[:readme] = file
        end

        #parser.on('--save', 'save options for future use') do |markup|
        #  options[:save] = true
        #end

        # TODO: shouldn't this be in .yardopts?
        parser.on('--markup TYPE', 'markup type used for comments (rdoc, md, tomdoc)') do |markup|
          options[:markup] = markup.to_sym
        end

        parser.on('-F', '--force') do
          $FORCE = true
        end

        parser.on_tail('--debug', 'run with $DEBUG set to true') do
          $DEBUG = true
        end
        parser.on_tail('--warn', 'run with $VERBOSE set to true') do
          $VERBOSE = true
        end

        parser.on_tail('--help', 'see this help message') do
          puts parser; exit -1
        end
      end

      # Is `$FORCE` set?
      #
      # Returns true or false.
      def force?
        !!$FORCE
      end

      # Is this a project directory?
      #
      # Returns true or false.
      def root?
        root = false
        root = true if File.exist?('.ruby')
        root = true if File.exist?('.yardoc')
        root = true if File.exist?('.rdoc')
        root = true if File.exist?('.git')
        root = true if File.exist?('.hg')
        root = true if File.exist?('_darcs')
        root
      end

    end

  end

end
