# encoding: utf-8

require 'ruby-plsql'
require_relative "./account"

class Idm

  def initialize
    connect
  end

  def fetch_employee
    records = []
    plsql.mitarbeiter_account_pkg.accountList { |c| records = c.fetch_all }

    records.reduce([]) do |accounts, record|
      accounts << Account.new(
        uid: record[0],
        firstname: record[1],
        lastname: record[2],
        mail: record[3]
      )
    end
  end

  def fetch_students
    records = []
    plsql.student_account_pkg.accountList { |c| records = c.fetch_all }

    records.reduce([]) do |accounts, record|
      accounts << Account.new(
        uid: record[0],
        firstname: record[1],
        lastname: record[2],
        mail: record[3]
      )
    end
  end

  def fetch
    fetch_employee + fetch_students
  end

private
  def connect
    plsql.connection ||= OCI8.new \
      ENV['IDM_USERNAME'],
      ENV['IDM_PASSWORD'],
      ENV['IDM_SID']
  end
end
