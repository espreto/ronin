#
# Ronin - A decentralized repository for the storage and sharing of computer
# security advisories, exploits and payloads.
#
# Copyright (c) 2007 Hal Brodigan (postmodern at users.sourceforge.net)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'formatstring'
require 'repo/platformexploitcontext'

module Ronin
  module Repo
    class FormatStringTargetContext < TargetContext

      def initialize(&block)
	# initialize formatstring metadata
	metadata_set(:pop_length,0)
	metadata_set(:address,0)
	metadata_set(:overwrite,0)

	super(&block)
      end

      def to_target
	FormatStringTarget.new(product_version,platform,pop_length,address,overwrite,comments)
      end

      protected

      # Pop length
      attr_metadata :pop_length

      # Address
      attr_metadata :address

      # Overwrite
      attr_metadata :overwrite

    end

    class FormatStringContext < PlatformExploitContext

      def initialize(path)
	super(path)
      end

      def create
	return FormatString.new(advisory) do |exp|
	  load_platformexploit(exp)
	end
      end

      protected

      # Name of object to load
      attr_object :formatstring

      def target(&block)
	@targets << FormatStringTargetContext.new(&block)
      end
      
    end
  end
end
