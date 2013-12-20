# Create a user agent object
use LWP::UserAgent;
$ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

#use strict;

# Create a request
my $req = HTTP::Request->new(POST => 'http://www.thedailygrowler.com/beers/');
#my $req = HTTP::Request->new(POST => 'C:\Users\Jeff\Documents\GitHub\DailyGrowlerPull\menu.html');
$req->content_type('application/x-www-form-urlencoded');
$req->content('query=libwww-perl&mode=dist');

# Pass request to the user agent and get a response back
my $res = $ua->request($req);

my $fullhtml;
# Check the outcome of the response
if ($res->is_success) {
  #print $res->content;
  $fullhtml = $res->content;
}
else {
  print $res->status_line, "\n";
}

my @tablesplit = split(/<\/?table.*>/,$fullhtml);

#$tablesplit[1] has what we want, work with that

my @clearout = split(/<\/?tr>/,$tablesplit[1]);
my @tablesplit;
foreach $clear (@clearout)
{
	if ($clear =~ /<t[hd].*>/)
	{
		push (@tablesplit,$clear);
	}
}
#print $tablesplit[1];

$length = @tablesplit;
#print "length = $length\n";

#start at $tablesplit[1] because 0 is garbage
#for loop goes to $length - 1 because $tablesplit[$length] is also garbage
#basically, $length - 2 should be 60, for 60 taps at Daily Growler
#print $tablesplit[1];
for (my $i=1; $i < $length-1; $i++)
{
	#special case for start, pull heading out
	if ($i == 1)
	{
		my @entries = split(/<\/?th.*?>/,$tablesplit[1]);
		my $entrysize = @entries;
		#my @entries = split (/<.*th.*>/,$tablesplit[1]);
		#my @entries = split(/<th class|<\/th>/,$tablesplit[1]);
		#print "here:\n@entries";
		foreach $entry (@entries)
		{
			if ($entry =~ /\w+/)
			{
				chomp($entry);
				print "$entry,";
			}
		}
	}
	else
	{
	}
}