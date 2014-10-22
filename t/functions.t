#!/usr/bin/perl

use strict;
use warnings;
use boolean qw(true);

use Math::Factor::XS ':all';
use Test::More tests => 31;

{
    my $number = 30107;

    my @factors = factors($number);
    my @matches = matches($number, \@factors);

    is(@factors, 14, "factors($number) - count of elements");
    is_deeply(\@factors, [
        7,11,17,23,77,119,161,187,253,391,1309,1771,2737,4301
    ], "factors($number) - numbers returned");
    is(@matches, 7, "matches($number) - count of elements");
    is_deeply(\@matches, [
        [7,4301], [11,2737], [17,1771], [23,1309], [77,391], [119,253], [161,187]
    ], "matches($number) - numbers returned");

    @matches = matches($number, \@factors, { skip_multiples => true });
    is(@matches, 4, "matches($number) - count of elements with 'skip_multiples' set");
    is_deeply(\@matches, [
        [7,4301], [11,2737], [17,1771], [23,1309]
    ], "matches($number) - numbers returned with 'skip_multiples' set");
}

{
    my $number = 16;

    my @factors = factors($number);

    is(@factors, 3, "factors($number) - count of elements");
    is_deeply(\@factors, [2,4,8], "factors($number) - numbers returned");
}

{
    # rt #53739
    my $number = 5;

    my @factors = factors($number);
    my @matches = matches($number, \@factors);

    ok(!@matches, "matches($number) - no factors provided");
}

{
  foreach my $elem ([ 0, '' ],
                    [ 1, '' ],
                    [ 2, '2' ],
                    [ 3, '3' ],
                    [ 4, '2,2' ],
                    [ 5, '5' ],
                    [ 6, '2,3' ],
                    [ 12, '2,2,3' ],
                    [ 64, '2,2,2,2,2,2' ],
                    [ 9, '3,3' ],
                    [ 27, '3,3,3' ],
                    [ 30, '2,3,5' ],
                    [ 34, '2,17' ],
                    [ 57, '3,19' ],

                    # medium size input, loop to sqrt(57128471)=7558
                    [ 114_256_942, '2,57128471' ],

                    [ 105, '3,5,7' ],
                    [ 2214143, '1487,1489' ],
                   ) {
    my ($number, $want) = @$elem;
    my @factors = prime_factors($number);
    my $got = join(',',@factors);
    is ($got, $want, "prime_factors($number)");
  }
}

{
  # croak on bad inputs
  ok (! eval { prime_factors(-1); 1 });
  require POSIX;
  my $dbl_max = POSIX::DBL_MAX();
  my $inf = 2 * $dbl_max;
  ok (! eval { prime_factors($dbl_max); 1 });
  ok (! eval { prime_factors($inf); 1 });
  ok (! eval { prime_factors(- $dbl_max); 1 });
  ok (! eval { prime_factors(- $inf); 1 });
}
