# encoding: utf-8

class Account
  attr_reader :id, :firstname, :lastname, :uid, :mail

  def initialize uid: nil, firstname: nil, lastname: nil, mail: nil
    @id = SecureRandom.uuid
    @uid = uid
    @firstname = firstname
    @lastname = lastname
    @mail = mail
  end

  def displayname
    "#{@firstname} #{@lastname}".strip
  end

  def checksum
    Digest::SHA1.hexdigest "#{@uid}#{@firstname}#{@lastname}#{@mail}"
  end


  def to_ldif
    {
      sn: lastname,
      givenname: firstname,
      mail: mail,
      cn: displayname,
      uid: checksum,
      carlicense: checksum,
      objectClass: ["top","inetOrgPerson"]
    }
  end
end
