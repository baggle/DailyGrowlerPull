# Create a user agent object
use LWP::UserAgent;
$ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

# Create a request
my $req = HTTP::Request->new(POST => 'http://www.thedailygrowler.com/beers/');
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

my @tablesplit = split(/<\/*table.*>/,$fullhtml);

#$tablesplit[1] has what we want, work with that

my @clearout = split(/<\/*tr>/,$tablesplit[1]);
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
print "length = $length\n";
for (my $i=0; $i < $length; $i++)
{
}