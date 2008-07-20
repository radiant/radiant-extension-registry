module ExtensionsHelper
  def installation_types_for_select
    [
      'Git',
      'Subversion',
      'Gem',
      ['Tar (.tar)', 'Tarball'],
      ['GZip (.tar.gz, .tgz)', 'Gzip'],
      ['BZip2 (.tar.bz2)', 'Bzip2'],
      ['Zip (.zip)', 'Zip']
    ]
  end
end
