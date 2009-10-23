#Represents an operation to be applied on the server
module Wavey
  module Models
    class Operation
      attr_reader :type, :wave_id, :wavelet_id, :blip_id, :index, :property
      
      #Constants
      # Types of operations
      WAVELET_APPEND_BLIP = 'WAVELET_APPEND_BLIP'
      WAVELET_ADD_PARTICIPANT = 'WAVELET_ADD_PARTICIPANT'
      WAVELET_CREATE = 'WAVELET_CREATE'
      WAVELET_REMOVE_SELF = 'WAVELET_REMOVE_SELF'
      WAVELET_DATADOC_SET = 'WAVELET_DATADOC_SET'
      WAVELET_SET_TITLE = 'WAVELET_SET_TITLE'
      BLIP_CREATE_CHILD = 'BLIP_CREATE_CHILD'
      BLIP_DELETE = 'BLIP_DELETE'
      DOCUMENT_ANNOTATION_DELETE = 'DOCUMENT_ANNOTATION_DELETE'
      DOCUMENT_ANNOTATION_SET = 'DOCUMENT_ANNOTATION_SET'
      DOCUMENT_ANNOTATION_SET_NORANGE = 'DOCUMENT_ANNOTATION_SET_NORANGE'
      DOCUMENT_APPEND = 'DOCUMENT_APPEND'
      DOCUMENT_APPEND_STYLED_TEXT = 'DOCUMENT_APPEND_STYLED_TEXT'
      DOCUMENT_INSERT = 'DOCUMENT_INSERT'
      DOCUMENT_DELETE = 'DOCUMENT_DELETE'
      DOCUMENT_REPLACE = 'DOCUMENT_REPLACE'
      DOCUMENT_ELEMENT_APPEND = 'DOCUMENT_ELEMENT_APPEND'
      DOCUMENT_ELEMENT_DELETE = 'DOCUMENT_ELEMENT_DELETE'
      DOCUMENT_ELEMENT_INSERT = 'DOCUMENT_ELEMENT_INSERT'
      DOCUMENT_ELEMENT_INSERT_AFTER = 'DOCUMENT_ELEMENT_INSERT_AFTER'
      DOCUMENT_ELEMENT_INSERT_BEFORE = 'DOCUMENT_ELEMENT_INSERT_BEFORE'
      DOCUMENT_ELEMENT_REPLACE = 'DOCUMENT_ELEMENT_REPLACE'
      DOCUMENT_INLINE_BLIP_APPEND = 'DOCUMENT_INLINE_BLIP_APPEND'
      DOCUMENT_INLINE_BLIP_DELETE = 'DOCUMENT_INLINE_BLIP_DELETE'
      DOCUMENT_INLINE_BLIP_INSERT = 'DOCUMENT_INLINE_BLIP_INSERT'
      DOCUMENT_INLINE_BLIP_INSERT_AFTER_ELEMENT = 'DOCUMENT_INLINE_BLIP_INSERT_AFTER_ELEMENT'

      #Options include:
      # - :type
      # - :wave_id
      # - :wavelet_id
      # - :blip_id
      # - :index
      # - :property
      def initialize(options = {})
        @type = options[:type]
        @wave_id = options[:wave_id]
        @wavelet_id = options[:wavelet_id]
        @blip_id = options[:blip_id]
        @index = options[:index] || -1
        @property = options[:property]
      end
      
      #Serialize the operation to hash
      def to_hash
        {
          'blipId' => @blip_id,
          'index' => @index,
          'waveletId' => @wavelet_id,
          'waveId' => @wave_id,
          'type' => @type,
          'javaClass' => 'com.google.wave.api.impl.OperationImpl',
          'property' => property_to_hash
        }
      end
      
      #Serialize teh operation to json
      def to_json
        to_hash.to_json
      end
      
    protected
      #Decide what kind of property it is and return the value that should be in the JSON
      def property_to_hash
        if @property.kind_of?(String)
          @property
        elsif @property.kind_of?(Range)
          {
            'javaClass' => 'com.google.wave.api.Range',
            'start' => @property.first,
            'end' => @property.last
          }
        else
          #TODO: What else needs to be in here?
          raise "I don't know what that property is..."
        end
      end
      
    end
  end
end