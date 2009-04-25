module ExtensionsHelper
  def repository_types_for_select
    [
      'Git',
      'Subversion'
    ]
  end
  def download_types_for_select
    [
      'Gem',
      ['Tar (.tar)', 'Tarball'],
      ['GZip (.tar.gz, .tgz)', 'Gzip'],
      ['BZip2 (.tar.bz2)', 'Bzip2'],
      ['Zip (.zip)', 'Zip']
    ]
  end
end
