<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xccdf="http://checklists.nist.gov/xccdf/1.1" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:dc="http://purl.org/dc/elements/1.1/">

<!-- This transform assembles all fragments into one "shorthand" XCCDF document
     Accepts the following parameters:

     * SHARED_RP	(required)	Holds the resolved ABSOLUTE path
					to the SSG's "shared/" directory.
-->

<!-- Define the default value of the required "SHARED_RP" parameter -->
<xsl:param name="SHARED_RP" select='undef' />


  <xsl:template match="Benchmark">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />

      <!-- Adding profiles here -->
      <!-- <xsl:apply-templates select="document('profiles/standard.xml')" /> -->
      <xsl:apply-templates select="document('profiles/stig-archlinux-disa.xml')" />
      <!-- <xsl:apply-templates select="document('profiles/common.xml')" /> -->

      <!-- Adding 'conditional_clause' placeholder <xccdf:Value> here -->
      <Value id="conditional_clause" type="string" operator="equals">
        <title>A conditional clause for check statements.</title>
        <description>A conditional clause for check statements.</description>
        <value>This is a placeholder.</value>
      </Value>

      <!-- Adding remediation functions from concat($SHARED_RP, '/xccdf/remediation_functions.xml')
           location here -->
      <xsl:if test=" string($SHARED_RP) != 'undef' ">
        <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/remediation_functions.xml'))" />
      </xsl:if>
      
      <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/intro/shared_intro_os.xml'))" />
      <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/system/system.xml'))" />
      
      <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/services.xml'))" />
    </xsl:copy>
  </xsl:template>

  <!-- <xsl:include href="../../shared/xccdf/shared_guide.xslt"/> -->

  <xsl:template match="Group[@id='system']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/system/accounts/accounts.xml'))" />
      <!-- <xsl:apply-templates select="document('xccdf/system/services/services.xml')" /> -->
      <xsl:apply-templates select="document(concat($SHARED_RP,'/xccdf/system/software/software.xml'))" />
      <xsl:apply-templates select="document(concat($SHARED_RP,'/xccdf/system/permissions/permissions.xml'))" />
      <xsl:apply-templates select="document('xccdf/system/auditing.xml')" />
      <!-- <xsl:apply-templates select="document('xccdf/system/auditing.xml')" /> -->
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='software']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <!-- <xsl:apply-templates select="document('xccdf/system/software/sudo.xml')" /> -->
      <xsl:apply-templates select="document('xccdf/system/software/sudo.xml')" />
      <xsl:apply-templates select="document('xccdf/system/software/integrity.xml')" />
      <xsl:apply-templates select="document('xccdf/system/software/disk_partitioning.xml')" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='permissions']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('xccdf/system/permissions/mounting.xml')" />
      <xsl:apply-templates select="document('xccdf/system/permissions/files.xml')" />
      <xsl:apply-templates select="document('xccdf/system/permissions/partitions.xml')" />
    </xsl:copy>
  </xsl:template>
 
  <xsl:template match="Group[@id='accounts']">
   <xsl:copy>
     <xsl:copy-of select="@*|node()" />
     <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/system/accounts/restrictions/restrictions.xml'))" />
     <xsl:apply-templates select="document('xccdf/system/accounts/pam.xml')" />
     <xsl:apply-templates select="document('xccdf/system/accounts/session.xml')" />
     <xsl:apply-templates select="document('xccdf/system/accounts/physical.xml')" />
     <xsl:apply-templates select="document('xccdf/system/accounts/banners.xml')" />
   </xsl:copy>
  </xsl:template>


  <xsl:template match="Group[@id='accounts-restrictions']">
   <xsl:copy>
     <xsl:copy-of select="@*|node()" />
     <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/root_logins.xml')" />
     <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/password_storage.xml')" /> 
     <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/password_expiration.xml')" />
     <xsl:apply-templates select="document('xccdf/system/accounts/restrictions/account_expiration.xml')" />
   </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='services']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/obsolete.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/base.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/cron.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/docker.xml'))" /> -->
      <xsl:apply-templates select="document('xccdf/services/ssh.xml')" />
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/sssd.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/xorg.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/avahi.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/printing.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/dhcp.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/ntp.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/mail.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/ldap.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/nfs.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/dns.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/ftp.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/http.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/imap.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/quagga.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/smb.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/squid.xml'))" /> -->
      <!-- <xsl:apply-templates select="document(concat($SHARED_RP, '/xccdf/services/snmp.xml'))" /> -->
    </xsl:copy>
  </xsl:template>

  <!-- copy everything else through to final output -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>