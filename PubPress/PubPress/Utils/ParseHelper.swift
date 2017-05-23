//
//  ParseHelper.swift
//  PubPress
//
//  Created by Zhuxian on 4/17/17.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseHelper {
    
    static func parseGooglePub(_ rawData: JSON) -> PubModel {
    
        //Pub result json
        /*
         "formatted_address": "279 Lake Rd, Webster, NY 14580, USA",
         "formatted_phone_number": "(585) 323-1224",
         "geometry": {
         "location": {
         "lat": 43.2373524,
         "lng": -77.5217097
         },
         "viewport": {
         "northeast": {
         "lat": 43.238795880291,
         "lng": -77.520447419708
         },
         "southwest": {
         "lat": 43.236097919708,
         "lng": -77.523145380291
         }
         }
         },
         "icon": "https://maps.gstatic.com/mapfiles/place_api/icons/bar-71.png",
         "id": "ba93fcfe254bd5e461251cfd75cd21c2a907a3f0",
         "international_phone_number": "+1 585-323-1224",
         "name": "Bay Side Pub",
         "opening_hours": {
         "open_now": true,
         "periods": [
         {
         "close": {
         "day": 1,
         "time": "0200"
         },
         "open": {
         "day": 0,
         "time": "1200"
         }
         },
         {
         "close": {
         "day": 2,
         "time": "0200"
         },
         "open": {
         "day": 1,
         "time": "1100"
         }
         },
         {
         "close": {
         "day": 3,
         "time": "0200"
         },
         "open": {
         "day": 2,
         "time": "1100"
         }
         },
         {
         "close": {
         "day": 4,
         "time": "0200"
         },
         "open": {
         "day": 3,
         "time": "1100"
         }
         },
         {
         "close": {
         "day": 5,
         "time": "0200"
         },
         "open": {
         "day": 4,
         "time": "1100"
         }
         },
         {
         "close": {
         "day": 6,
         "time": "0200"
         },
         "open": {
         "day": 5,
         "time": "1100"
         }
         },
         {
         "close": {
         "day": 0,
         "time": "0200"
         },
         "open": {
         "day": 6,
         "time": "1100"
         }
         }
         ],
         "weekday_text": [
         "Monday: 11:00 AM – 2:00 AM",
         "Tuesday: 11:00 AM – 2:00 AM",
         "Wednesday: 11:00 AM – 2:00 AM",
         "Thursday: 11:00 AM – 2:00 AM",
         "Friday: 11:00 AM – 2:00 AM",
         "Saturday: 11:00 AM – 2:00 AM",
         "Sunday: 12:00 PM – 2:00 AM"
         ]
         },
         "photos": [
         {
         "height": 2340,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/107982433436340181497/photos\">Joe Hellaby</a>"
         ],
         "photo_reference": "CmRYAAAABFf3qkQnUEoEovKp3jOlUmOmDxGLzcG_pS15G3fjwNMyNxH1klabOljyZAlfLQrKFpbK-tQxfYhSsAyQXqt3K2rRQM7AiTD4CqrIWM7PvEK8BNfcFb6XUoMG_WpbHODYEhCFz2WW5JNszJHHj1fgALd8GhR1hPC4q_RHOuzZ3AjXuVphQGcF2Q",
         "width": 4160
         },
         {
         "height": 2322,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/113234593249790059073/photos\">Connie Heid</a>"
         ],
         "photo_reference": "CmRYAAAAEbObct7YVF7qvpuYC_Me6_BhcRWPNYM6A8CJAaEFtmzFOolE5l0tPz8PTcKQhcydMG9UP-Pg9aJCKlNImRv1cjFrXaxUpMwjdOQ5qIn7wU1aX0wxMqrk_NfiARb4zSzSEhCKsHayDAnQXOiqhcB4lFrbGhSEuu0TtNuD6ppNf9QBVPdVjxqLfg",
         "width": 4128
         },
         {
         "height": 2988,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/112515036406199620397/photos\">Johnathan Blades</a>"
         ],
         "photo_reference": "CmRYAAAACwrNnN669bebGHRslbV_NmqYrIQMcgQXrP7dOemhNdAO1-XZox8zFEEwDabblAFVmTr9jIfpAlk-Tt_QC9oCMtVW7OZkJABUfNdPiFTKgWFWE3_Tf0bl7ZGIHSZM3ZfpEhC2QyeJr9o_9vl-tVMMyhBzGhT8FKPE6L5VpgOdSF5yskrJisYabg",
         "width": 5312
         },
         {
         "height": 5312,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/101878597980418450100/photos\">Junior Junior</a>"
         ],
         "photo_reference": "CmRYAAAA2U2YJJkeAYUXklSIx1QK_JMlAlaq4k6Zwnqj3zQ-eWQ2eCgaCDkHzfA9GEg6NUm11sldI8p459uzZtYO11Zux1qd-QAYtF2tp-g5SjHH6v2wNIL9nsqMhJGWHEAVQ72kEhCi0ygipVcLtp70GpS_crafGhSFVmAWzng2FFBs4LxvEYYksOoSow",
         "width": 2988
         },
         {
         "height": 3096,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/105884140400857888585/photos\">mike Tumm</a>"
         ],
         "photo_reference": "CmRYAAAAjP49B1ejnapFznyL5PDiMNHxpuXwy2vWO4xG3YhyV8ZD_mIYyTMC5gqSasDalf8hfsmMxY74adHf8t-aI0cpeVYm47Q2kdCjJOjC-XT6wjSw-l1q0mrSnqpSxSqR-fkCEhCcOsfQWDs0SprNWhcmBtCEGhR5cjkiQtqE_tjzKFaNJ-a_wsxP1Q",
         "width": 4128
         },
         {
         "height": 3264,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/113475729536890255805/photos\">Tiffany D&#39;Angelo</a>"
         ],
         "photo_reference": "CmRYAAAAr5yZTDx7hTb7i2vnrqZaZKFuq79RAXsWslpAL8e4lZwzlrTMwj0CBJTg8jVLbW7sabZcE9Mz-ckPPdyAfJitSndyXTdBMVHIiOTrR7qznnKniSdi_9H0F-K48d6e-aUEEhBTlZ-1UcXI48VQ0PKXUXYaGhSrYKAbSOLTKXYEmS2tgUAGv6pOkw",
         "width": 1836
         },
         {
         "height": 5248,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/103874245724594875081/photos\">Jim Oneil</a>"
         ],
         "photo_reference": "CmRYAAAAaRQYR81ODCEl_iavdRtWmg4s8bFso56AtP6jmgd4mE23SoGGmoO6wYKfdA18Lws0QVProOo89-dEg2lxi9o8IFmNTaBlYuRFQrtPz0DjdVY8FR7NnOeCDeQ9DM2WcCE2EhAVK-COdKFQK4VDMEUrTj7fGhTBqcyN3fQPAryaMI3_M3ol7RY5-g",
         "width": 2952
         },
         {
         "height": 5248,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/107569273338262946939/photos\">Timothy Stone</a>"
         ],
         "photo_reference": "CmRYAAAAAIoBeXX7pRUam1Wu6wFFpnOo1xYvlHzLLPqgoXaz8qBKOXyxni2hlQEgHgQdLzhY-bpOVNVT93FcNyxdGzM-3PUSMia7K1JW0a-XSOlLnW2PL3op3gq7XEBHWrYRdSLeEhAqTgSk7xGVOOnaLhTbJLfGGhRJ8bMjJWE1amkL1tPbyvfkvfTrug",
         "width": 2952
         },
         {
         "height": 3096,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/105884140400857888585/photos\">mike Tumm</a>"
         ],
         "photo_reference": "CmRYAAAADhqKQmyQjieh-sWp-MVmBmdVDRf9tous3K6N-pdYF3EBPa0zbiC_0q-9FMbVDjWC6BI287_9mNWkcyZGemO8UtrFhhprLqCBFPI7L5xLDWe-aRTqwEZmhAitzLbH6EeVEhDeabhNaKpPmD10TGXG-bgiGhSiDGbrWz8-qi8qIqzwTuu0dNmgMA",
         "width": 4128
         },
         {
         "height": 2322,
         "html_attributions": [
         "<a href=\"https://maps.google.com/maps/contrib/116049129141591008821/photos\">Jenny Dale</a>"
         ],
         "photo_reference": "CmRYAAAAxJUEnCaKx4vjVFJa1DmlYEJmV3TnAfsfYa217WvGj6Qg-wIkSkchNsvDqCLQfGdVF_H9KhMsOJ3WvrPkRTMkMAgq9MyZopKGKCRnA1sM_tkvhRPbb4VpMWy0Z6_tADxYEhBQVgeAv7UQhpqzch9lCZk2GhQlE29avlDNab17g-f-314wFKSiwQ",
         "width": 4128
         }
         ],
         "place_id": "ChIJ1YN3nl7I1okRdg01-poiBXc",
         "price_level": 2,
         "rating": 4.3,
         "reference": "CmRRAAAABsNEL18qylHYik_0-yWLT2REHLr2dUR9n_U-uOAwaCfDQJ9LCTbaJHfMYfqW7E2fcPwQQ9ku6hTU214G_qoNx5QGd7YxsmhEHnOr3AOZZZ1cAOARGwyJHy08gVtvepYyEhCNNNIAyMLRsWkuQKWhu-B7GhSJjTbB_6zoE0F0agEq3BvdunkJSA",
         "reviews": [
         {
         "aspects": [
         {
         "rating": 3,
         "type": "overall"
         }
         ],
         "author_name": "Matt sharpe",
         "author_url": "https://www.google.com/maps/contrib/113578992482632453878/reviews",
         "language": "en",
         "profile_photo_url": "https://lh4.googleusercontent.com/-JvkgP2NXo4k/AAAAAAAAAAI/AAAAAAAAAAA/AHalGhrJu4bkZ40r0POhmqhHKzCkBvyHrg/s128-c0x00000000-cc-rp-mo-ba1/photo.jpg",
         "rating": 5,
         "relative_time_description": "a month ago",
         "text": "Love being at the bayside. Pull up my boat or my jetski to the dock and have some dinner or a beer. Wonderful little dive bar with impressive food options and a lot of outside seating and live music right next to you! Right on the bay and across the street from the lake. A true diamond in the rough...on the water!",
         "time": 1491537626
         },
         {
         "aspects": [
         {
         "rating": 3,
         "type": "overall"
         }
         ],
         "author_name": "Igor Khokhlov",
         "author_url": "https://www.google.com/maps/contrib/108769650105155794891/reviews",
         "language": "en",
         "profile_photo_url": "https://lh3.googleusercontent.com/-X8uIVyKd63I/AAAAAAAAAAI/AAAAAAABIiY/82ZfUoMtHAg/s128-c0x00000000-cc-rp-mo-ba1/photo.jpg",
         "rating": 5,
         "relative_time_description": "4 weeks ago",
         "text": "Nice view. Tasty food",
         "time": 1491915440
         },
         {
         "aspects": [
         {
         "rating": 2,
         "type": "overall"
         }
         ],
         "author_name": "Wesley Moon",
         "author_url": "https://www.google.com/maps/contrib/115032688786102095974/reviews",
         "language": "en",
         "profile_photo_url": "https://lh4.googleusercontent.com/-EH-gxVwb4Ig/AAAAAAAAAAI/AAAAAAAACMo/wvfEd9W3reY/s128-c0x00000000-cc-rp-mo-ba1/photo.jpg",
         "rating": 4,
         "relative_time_description": "7 months ago",
         "text": "The food here is delicious. Four stars due to their burgers being 10 dollars each and paying extra for fries. They also need to trent outside of their dock. Be carefull pulling up to their dock with a boat; its only 2-4 feet deep, and it ruined my prop. Small, quiet place great for a cute date idea, but keep in mind their prices so you aren't surprised. Wonderful, pleasant workers as well, just need to fix the shallow entrance by boat and i would be there every weekend.",
         "time": 1474815214
         },
         {
         "aspects": [
         {
         "rating": 2,
         "type": "overall"
         }
         ],
         "author_name": "J.T. Irizarry",
         "author_url": "https://www.google.com/maps/contrib/110617910389155484316/reviews",
         "language": "en",
         "profile_photo_url": "https://lh5.googleusercontent.com/-_w3JAHlYaMk/AAAAAAAAAAI/AAAAAAABWFE/AjPrcVOToZM/s128-c0x00000000-cc-rp-mo-ba1/photo.jpg",
         "rating": 4,
         "relative_time_description": "a year ago",
         "text": "Good food at affordable pricing. The place if right on the bay so location looks great. When you first arrive it may look like a rundown shack, but stay and you will be surprised with great food. I recommend the bay burger. No matter what anyone says the ribs are not as special as they sound. If you want ribs try a BBQ place.",
         "time": 1461774704
         },
         {
         "aspects": [
         {
         "rating": 2,
         "type": "overall"
         }
         ],
         "author_name": "mike Tumm",
         "author_url": "https://www.google.com/maps/contrib/105884140400857888585/reviews",
         "language": "en",
         "profile_photo_url": "https://lh3.googleusercontent.com/-A3Bb5fzmI5A/AAAAAAAAAAI/AAAAAAAAAAA/AHalGhpZbhSXFLxRZYO-EIcmB0k_3tQSvw/s128-c0x00000000-cc-rp-mo-ba1/photo.jpg",
         "rating": 4,
         "relative_time_description": "a week ago",
         "text": "cozy with fun help and the best liquor on the bay!",
         "time": 1493247205
         }
         ],
         "scope": "GOOGLE",
         "types": [
         "bar",
         "restaurant",
         "food",
         "point_of_interest",
         "establishment"
         ],
         "url": "https://maps.google.com/?cid=8576299114415066486",
         "utc_offset": -240,
         "vicinity": "279 Lake Road, Webster",
         "website": "http://www.baysidepubwebster.com/index.html"
         },
         "status": "OK"
        */
        
        let pub = PubModel()
        pub.pub_id = rawData[Constants.KEY_PUB_ID].nonNullStringValue
        //pub.pub_iconurl = rawData[Constants.KEY_PUB_ICON].nonNullStringValue
        pub.pub_placeid = rawData[Constants.KEY_PUB_PLACE_ID].nonNullStringValue
        pub.pub_vicinity = rawData[Constants.KEY_PUB_VINICITY].nonNullStringValue
        pub.pub_name = rawData[Constants.KEY_PUB_NAME].nonNullStringValue
        let geometry = rawData[Constants.KEY_PUB_GEOMETRY]
        let location = geometry[Constants.KEY_PUB_LOCATION]
        pub.pub_latitude = location[Constants.KEY_PUB_LAT].nonNullDoubleValue
        pub.pub_longitude = location[Constants.KEY_PUB_LON].nonNullDoubleValue
        let openingHours = rawData[Constants.KEY_PUB_OPENINGHOURS]
        pub.pub_opennow = openingHours[Constants.KEY_PUB_OPENNOW].nonNullBoolValue        
        let weekdayTextArray = openingHours[Constants.KEY_PUB_WEEKDAY_TEXT].arrayValue
        for weekdayObject in weekdayTextArray {
            pub.pub_openhours.append(weekdayObject.nonNullStringValue)
        }
        let photoObject = rawData[Constants.KEY_PUB_PHOTOS].arrayValue
        if photoObject.count > 0{
            pub.photo_reference = photoObject[0][Constants.KEY_PUB_PHOTOREFERENCE].nonNullStringValue
        }
        pub.pub_formatted_phone_number = rawData[Constants.KEY_PUB_PHONENUMBER].nonNullStringValue
        pub.pub_formatted_address = rawData[Constants.KEY_PUB_ADDRESS].nonNullStringValue
        
        
        return pub
        
    }
    
    static func parsePub(_ rawData: JSON) -> PubModel{
        let pub = PubModel()
        
        
        return pub
    }
    
    static func parseUser(_ rawData: JSON) -> UserModel{
        
        let user = UserModel()
        user.user_id = rawData[Constants.KEY_USER_ID].nonNullStringValue
        user.user_name = rawData[Constants.KEY_USER_NAME].nonNullStringValue
        user.user_profileimageurl = rawData[Constants.KEY_USER_PROFILEIMAGEURL].nonNullStringValue
        user.user_decadence = rawData[Constants.KEY_USER_DECARDENCE].nonNullStringValue
        user.user_tier = rawData[Constants.KEY_USER_TIER].nonNullStringValue
        user.user_netpints = rawData[Constants.KEY_USER_NETPINTS].nonNullStringValue
        user.user_credits = rawData[Constants.KEY_USER_CREDITS].nonNullStringValue
        return user
    }
	
    
}
