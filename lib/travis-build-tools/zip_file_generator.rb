require 'zip'
# From https://github.com/rubyzip/rubyzip
# This is a simple example which uses rubyzip to
# recursively generate a zip file from the contents of
# a specified directory. The directory itself is not
# included in the archive, rather just its contents.
#
# Usage:
#   directoryToZip = "/tmp/input"
#   outputFile = "/tmp/out.zip"
#   zf = ZipFileGenerator.new()
#   zf.write(directoryToZip, outputFile)
module TravisBuildTools
  class ZipFileGenerator
    # Initialize with the directory to zip and the location of the output archive.
    def initialize()
    end

    # Zip the input directory.
    def write(inputDir, outputFile)
      entries = Dir.entries(inputDir); entries.delete("."); entries.delete("..")
      io = Zip::File.open(outputFile, Zip::File::CREATE);
   
      writeEntries(entries, "", io, inputDir)
      io.close();
    end

    def unzip_file(file, directory)
      Zip::File.open(file) do |zip_file|
        zip_file.each do |f|
          extraction_location = File.join(directory, f.name)
          FileUtils.mkdir_p(directory)
          zip_file.extract(f, extraction_location)
        end
      end
    end

    # A helper method to make the recursion work.
    private
    def writeEntries(entries, path, io, inputDir)
      entries.each { |e|
        zipFilePath = path == "" ? e : File.join(path, e)
        diskFilePath = File.join(inputDir, zipFilePath)
        puts "Deflating " + diskFilePath
        if  File.directory?(diskFilePath)
          io.mkdir(zipFilePath)
          subdir =Dir.entries(diskFilePath); subdir.delete("."); subdir.delete("..")
          writeEntries(subdir, zipFilePath, io, inputDir)
        else
          io.get_output_stream(zipFilePath) { |f| f.puts(File.open(diskFilePath, "rb").read())}
        end
      }
    end
  end
end
