#!/usr/bin/perl -w
use strict;
use Ham::Resources::HamQTH;
use Getopt::Std;

my ($input, $debug);

our $opt_d;
getopts('d');
if ($opt_d) { $debug = 1; }



while ()  {
   print "\nEnter callsign (q to exit): ";
   chomp($input = <STDIN>);
   if ($input eq "q" || $input eq "Q") { exit; }
   unless ($input) { print "Please enter a callsign! \n"; next; }
    display_it(get_info($input));
    
}

sub get_info {
    my $call = shift;
    my $bio;
    my $qth = Ham::Resources::HamQTH->new(
                                #callsign => $call,
                                username => 'ky4j',
                                password => ''
    );
   # my $sess = $qth->get_session();  Does not seem to work
    #print "Session is: $sess \n\n";
    $qth->set_callsign("$call");
    $bio = $qth->get_bio();
    if ($debug) { bio($bio) }
    return $bio;
}

sub bio {
    my $bio = shift;
    foreach my $key ( sort keys %{$bio} ) {
    print $key.": ". $bio->{ $key }. "\n";
    }
}
sub display_it {
   my $listing = shift;
   print "\nCountry: $listing->{ country }       Call: " . uc($listing->{ callsign }) . "\n";
   if ($listing->{ nick }) { print "Handle: $listing->{ nick } \n"; }
   if ($listing->{ adr_name }) { print "Name: $listing->{ adr_name } \n"; }
   if ($listing->{ adr_street1 }) { print "Addr1: $listing->{ adr_street1 } \n"; }
   if ($listing->{ adr_street2 }) { print "Addr2: $listing->{ adr_street2 }\n"; }# else { print "\n"; }
   if ($listing->{ adr_street3 }) { print "Addr3: $listing->{ adr_street3 }\n"; }# else { print "\n"; }
   if ($listing->{ adr_city}) { print "City: $listing->{ adr_city } "; }
   if ($listing->{ us_state }) { print "             State: $listing->{ us_state }\n"; } else { print "\n"; }
   if ($listing->{ us_county }) { print "County: $listing->{ us_county }\n"; }
   if ($listing->{ web }) { print "URL: $listing->{ web }\n";
       } #elsif
       #($listing->{ url }) { print "URL: $listing->{ bio }\n";
   #}
   if ($listing->{ grid }) { print "Grid: $listing->{ grid }\n"; }
   if ($listing->{ qsl_via }) { print "QSL Mgr: $listing->{ qsl_via }\n";}
   ($listing->{ lotw } eq 'Y') ? print "LoTW: Yes\n" : print "LoTW: No\n";
   ($listing->{ eqsl } eq 'Y') ? print "eqsl: Yes\n" : print "eqsl: No\n";
   ($listing->{ qsl } eq 'Y') ? print "Mail QSL: Yes\n" : print "Mail QSL: No\n";  
}
