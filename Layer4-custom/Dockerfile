#-- Boilerplate --
#
#
# This must be a layer-3 image
# Use the default unless you're customizing layer-3 or below
#FROM nodeos/base
FROM layer3
#
# Important to have /home/root/bin binaries accessible
ENV HOME /home/root
ENV PATH /home/root/bin:/usr/bin
#
# Use `init` to boot the system
# You should probably not change this
ENTRYPOINT ["/init"]
#
#
#-- /Boilerplate --

ADD USERS/ /home/

# Tell us who you are! 
# Replace the following with your own contact
MAINTAINER Jacob Groundwater <groundwater@gmail.com>

# The CMD is run *after* init
# You can customize this

# Drop into a shell immediately after boot
CMD ["nsh"]

# -OR-

# Run a package immediately after boot
# CMD ["npkg","start","<PKG_NAME>"]

INTERACTIVE yes
TTY yes
