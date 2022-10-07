class GeneralQueries{

  static String initialQuery = """
    query GetContent(\$languageCode: String!, \$municipalityId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        article
        category_id{
          objectId
          image_file{
            url
          }
        }
      }
      
      getItemNames(languageCode: \$languageCode){
        title
        synonyms
        item_id{
          objectId
        }
      }
      
      getAllCategoryMyths(languageCode: \$languageCode, municipalityId: \$municipalityId){
        question
        answer
        category_myth_id{
          category_id{
     		    objectId
      	    image_file{
        	    url
      	    }
      	    hex_color
    	    }
    	    is_correct
    	    source_link
    	    source_name
        }
      }
      
      getAllCategoryContent(languageCode: \$languageCode, municipalityId: \$municipalityId){
        item_list
        category_content_id{
          does_belong
          category_id{
            objectId
          }
        }
      }
      
      getAllCategoryCycles(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        explanation
        additional_info
        category_cycle_id{
          position
          image{
            url
          }
		      category_id{
		        objectId
            pictogram
          }
        }
      }
      
      getSubcategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        subcategory_id{
          objectId
          category_id{
            objectId
          }
        }
      }

      getForumEntryTypes(languageCode: \$languageCode){
        text
        button_text
        title
        forum_entry_type_id{
          objectId
          type_name
        }
      }
      
      getCollectionPoints(municipalityId: \$municipalityId){
        objectId
        opening_hours
        hazardous_materials
        second_hand
        contact_id{
          phone
          fax
          email
          website
        }
        address_id{
          street
          number
          zip_code
          district
          location{
            latitude
            longitude
          }
        }
        collection_point_type_id{
          objectId
        }
      }
      
      getDistinctSubcategoriesForCP(languageCode: \$languageCode, municipalityId: \$municipalityId){
        objectId
		    title
      }
      
      getCollectionPointTypes(languageCode: \$languageCode){
        title
        collection_point_type_id{
          objectId
          link
        }
      }
      
      getSubcategoriesOfAllCollectionPoints(languageCode: \$languageCode, municipalityId: \$municipalityId){
        collection_point_id{
          objectId
        }
        subcategory_id{
          objectId
        }
      }
      
      getZipCodes(municipalityId: \$municipalityId){
        objectId
        municipality_id{
          objectId
        }
        zip_code
        lat_lng{
          latitude
          longitude
        }
      }
    }
  """;

  static String getZipCodes = """
    query GetZipCodes(\$municipalityId: String!){
      getZipCodes(municipalityId: \$municipalityId){
        objectId
        municipality_id{
          objectId
        }
        zip_code
        lat_lng{
          latitude
          longitude
        }
      }
    }
  """;

  static String municipalityQuery = """
    query GetMunicipalities{
      getMunicipalities{
        objectId
        name
      }
    }
  """;

  static String categoryQuery = """
    query GetContent(\$languageCode: String!, \$municipalityId: String!){
      getCategories(languageCode: \$languageCode, municipalityId: \$municipalityId){
        title
        category_id{
          objectId
          image_file{
            url
          }
        }
      }
    }
  """;

}
