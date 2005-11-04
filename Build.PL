# Note: this file has been initially created by Module::Build::Convert 0.21

use 5.008007;

use Module::Build;

my $build = Module::Build->new
  (
   module_name => 'Math::Factor::XS',
   dist_version_from => 'lib/Math/Factor/XS.pm',
   dist_author => 'Steven Schubiger <schubiger@cpan.org>',
   requires => {
                 'Exporter' => 0,
		 'XSLoader' => 0,
               },
   recommends => {},
   build_requires => {},
   conflicts => {},
   xs_files => { 'XS.xs' => 'blib/Math/Factor/XS.xs' },
   license => 'perl',
   create_readme => 1,
   create_makefile_pl => 'passthrough',
  );
  
$build->create_build_script;
