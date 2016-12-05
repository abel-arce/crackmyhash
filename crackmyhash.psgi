use strict;
use warnings;

use crackmyhash;

my $app = crackmyhash->apply_default_middlewares(crackmyhash->psgi_app);
$app;

