################################################################################
#
# etherlab
#
################################################################################

ETHERLAB_VERSION = stable-1.5
ETHERLAB_SITE = http://hg.code.sf.net/p/etherlabmaster/code
ETHERLAB_SITE_METHOD = hg
ETHERLAB_SOURCE = etherlab-$(ETHERLAB_VERSION).tar.gz
ETHERLAB_LICENSE = GPL-2.0 (IgH EtherCAT master), LGPL-2.1 (libraries)
ETHERLAB_LICENSE_FILES = COPYING COPYING.LESSER
ETHERLAB_AUTORECONF = YES
ETHERLAB_DL_OPTS = -b $(ETHERLAB_VERSION) -r $(ETHERLAB_VERSION)

ETHERLAB_INSTALL_STAGING = YES

ETHERLAB_CONF_OPTS = \
	--with-linux-dir=$(LINUX_DIR)

ETHERLAB_CONF_OPTS += $(if $(BR2_PACKAGE_ETHERLAB_GENERIC),--enable-generic,--disable-generic)
ETHERLAB_CONF_OPTS += $(if $(BR2_PACKAGE_ETHERLAB_8139TOO),--enable-8139too,--disable-8139too)
ETHERLAB_CONF_OPTS += $(if $(BR2_PACKAGE_ETHERLAB_E100),--enable-e100,--disable-e100)
ETHERLAB_CONF_OPTS += $(if $(BR2_PACKAGE_ETHERLAB_E1000),--enable-e1000,--disable-e1000)
ETHERLAB_CONF_OPTS += $(if $(BR2_PACKAGE_ETHERLAB_E1000E),--enable-e1000e,--disable-e1000e)
ETHERLAB_CONF_OPTS += $(if $(BR2_PACKAGE_ETHERLAB_R8169),--enable-r8169,--disable-r8169)

# Since we download ethercat from source control, we have to emulate
# the bootstrap script that creates the ChangeLog file before running
# autoreconf.  We don't want to run that script directly, since we
# leave to the autotargets infrastructure the responsability of
# running 'autoreconf' so that the dependencies on host-automake,
# host-autoconf and al. are correct.
define ETHERLAB_CREATE_CHANGELOG
	touch $(@D)/ChangeLog
endef

ETHERLAB_POST_PATCH_HOOKS += ETHERLAB_CREATE_CHANGELOG

$(eval $(kernel-module))
$(eval $(autotools-package))
