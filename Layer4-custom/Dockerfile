#-- Boilerplate --
#
#
# This must be a layer-3 image
# Use the default unless you're customizing layer-3 or below
FROM nodeos/base
#
# Important to have /root/bin binaries accessible
ENV HOME /root
ENV PATH /root/bin:/usr/bin:/usr/sbin:/bin:/sbin
#
# Use `init` to boot the system
# You should probably not change this
ENTRYPOINT ["init"]
#
#
#-- /Boilerplate --






# Tell us who you are! 
# Replace the following with your own contact
MAINTAINER Jacob Groundwater <groundwater@gmail.com>







# Use the `npkg` command to customize your build
# Each installed package will expose new funtionality
# to the NodeOS system

# Customize Your Build Here
# ------------------------

# point NodeOS through proxy
ADD npmrc /root/.npmrc

RUN npkg install bin-nsh
RUN npkg install bin-man
RUN npkg install bin-fs
RUN npkg install bin-cat
RUN npkg install bin-pwd
RUN npkg install bin-ifconfig
RUN npkg install wssh
# ------------------------








# The CMD is run *after* init
# You can customize this

# Drop into a shell immediately after boot
CMD ["nsh"]

# -OR-

# Run a package immediately after boot
# CMD ["npkg","start","<PKG_NAME>"]

INTERACTIVE yes
TTY yes
