require 'digest'


module MachineID
  class << self
    def host_os
      RbConfig::CONFIG['host_os']
    end
    
    def windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def bsd?
      self.host_os =~ /bsd/
    end

    def windows64?
      self.windows? && (/x64/ =~ self.host_os) != nil
    end

    def mac?
      self.host_os =~ /mac|darwin/
    end

    def unix?
      self.host_os =~ /mswin|mingw/
    end

    def linux?
      self.host_os =~ /linux|cygwin/
    end


    def ID?(original = false)
      self.getMachineId?(original)
    end

    def hash?(guid)
      Digest::SHA256.hexdigest(guid)
    end

    def windowCmd
      cmd = '\\REG.exe QUERY HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Cryptography /v MachineGuid'
      return cmd if self.win64?
      return "%windir%\\System32#{cmd}"
    end

    def getCommand
      return 'ioreg -rd1 -c IOPlatformExpertDevice' if self.mac?
      return self.windowCmd if self.mac?
      return 'kenv -q smbios.system.uuid || sysctl -n kern.hostuuid' if self.bsd?
      return '( cat /var/lib/dbus/machine-id /etc/machine-id 2> /dev/null || hostname ) | head -n 1 || :' if self.linux?

    end

    def expose?(result)
      if self.mac?
        result.split('IOPlatformUUID')[1].split("\n")[0].gsub(/\=|\s+|\"/i, '')
      elsif self.windows?
        result.split('REG_SZ')[1].gsub(/\r+|\n+|\s+/i, '')
      elsif self.linux?
        result.gsub(/\r+|\n+|\s+/i, '')
      elsif self.bsd?
        result.gsub(/\r+|\n+|\s+/i, '')
      else
        'Platform not supported. Please report your platform and architecture in a new Github issue'
        exit(1)
      end
    end

    def getMachineId?(original = false)
      cmd = self.getCommand
      result = self.expose?(`#{cmd}`)
      return result if original == true
      self.hash?(result.downcase)
    end
  end
end