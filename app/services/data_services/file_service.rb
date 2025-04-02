module DataServices
  class FileService

    def initialize(file)
      raise "File not found" unless file.present?
      @file = File.readlines(file).map(&:chomp)
    end

    def call
      DataServices::NormalizerService.process_data(@file)
    end
  end
end
