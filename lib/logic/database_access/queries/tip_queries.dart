class TipQueries{

  static String tipListQuery = """
    query GetTips(\$languageCode: String!, \$userId: String){
      getTipTypes(languageCode: \$languageCode){
        title
        tip_type_id{
          objectId
          color
          default_label
        }
      }
      
      getTips(languageCode: \$languageCode){
        tip_id{
          objectId
    	    tip_type_id{
    	      objectId
      	    color
    	    },
    	    image{
    	      url
    	    }
  	    }, 
        title,
        explanation,
        short
      }
      
      getTipSubcategories{
        tip_id{
          objectId
        }
        subcategory_id{
          objectId
        }
      }
      
      getTipBookmarks(userId: \$userId){
        tip_id{
          objectId
        }
      }
    }
  """;

  static String tipDetailQuery = """
    query GetTip(\$languageCode: String!, \$tipId: String!){
      getTip(languageCode: \$languageCode, tipId: \$tipId){
        tip_id{
          objectId
    	    tip_type_id{
    	      objectId
      	    color
    	    },
    	    image{
    	      url
    	    }
  	    }, 
        title,
        explanation,
        short
      }
    }
  """;
}