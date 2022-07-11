//
//  Photo.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 1.07.2022.
//

import Foundation

/*
 {
       "id":"Yh2Y8avvPec",
       "created_at":"2021-05-21T11:13:48-04:00",
       "updated_at":"2022-06-29T12:31:10-04:00",
       "promoted_at":"2021-05-21T11:54:03-04:00",
       "width":4000,
       "height":5000,
       "color":"#a6a6a6",
       "blur_hash":"LNG8+YnhVsIUNgxZM{xZ00IooKW=",
       "description":"Creating my Content Creator Icon Pack!\n\nyou can get it from https://nublson.gumroad.com/#nEckj",
       "alt_description":"man in black framed eyeglasses holding black smartphone",
       "urls":{
          "raw":"https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?ixid=MnwzNDA5MDV8MXwxfGFsbHwxMXx8fHx8fDJ8fDE2NTY1OTUxNTk\u0026ixlib=rb-1.2.1",
          "full":"https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?crop=entropy\u0026cs=tinysrgb\u0026fm=jpg\u0026ixid=MnwzNDA5MDV8MXwxfGFsbHwxMXx8fHx8fDJ8fDE2NTY1OTUxNTk\u0026ixlib=rb-1.2.1\u0026q=80",
          "regular":"https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?crop=entropy\u0026cs=tinysrgb\u0026fit=max\u0026fm=jpg\u0026ixid=MnwzNDA5MDV8MXwxfGFsbHwxMXx8fHx8fDJ8fDE2NTY1OTUxNTk\u0026ixlib=rb-1.2.1\u0026q=80\u0026w=1080",
          "small":"https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?crop=entropy\u0026cs=tinysrgb\u0026fit=max\u0026fm=jpg\u0026ixid=MnwzNDA5MDV8MXwxfGFsbHwxMXx8fHx8fDJ8fDE2NTY1OTUxNTk\u0026ixlib=rb-1.2.1\u0026q=80\u0026w=400",
          "thumb":"https://images.unsplash.com/photo-1621609764095-b32bbe35cf3a?crop=entropy\u0026cs=tinysrgb\u0026fit=max\u0026fm=jpg\u0026ixid=MnwzNDA5MDV8MXwxfGFsbHwxMXx8fHx8fDJ8fDE2NTY1OTUxNTk\u0026ixlib=rb-1.2.1\u0026q=80\u0026w=200",
          "small_s3":"https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1621609764095-b32bbe35cf3a"
       },
       "links":{
          "self":"https://api.unsplash.com/photos/Yh2Y8avvPec",
          "html":"https://unsplash.com/photos/Yh2Y8avvPec",
          "download":"https://unsplash.com/photos/Yh2Y8avvPec/download?ixid=MnwzNDA5MDV8MXwxfGFsbHwxMXx8fHx8fDJ8fDE2NTY1OTUxNTk",
          "download_location":"https://api.unsplash.com/photos/Yh2Y8avvPec/download?ixid=MnwzNDA5MDV8MXwxfGFsbHwxMXx8fHx8fDJ8fDE2NTY1OTUxNTk"
       },
       "categories":[
          
       ],
       "likes":1232,
       "liked_by_user":false,
       "current_user_collections":[
          
       ],
       "sponsorship":{
          "impression_urls":[
             "https://ad.doubleclick.net/ddm/trackimpi/N1224323.3286893UNSPLASH/B25600467.324553021;dc_trk_aid=517636252;dc_trk_cid=157730382;ord=[timestamp];dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=;ltd=?",
             "https://secure.insightexpressai.com/adServer/adServerESI.aspx?script=false\u0026bannerID=10082942\u0026rnd=[timestamp]\u0026redir=https://secure.insightexpressai.com/adserver/1pixel.gif",
             "https://pixel.adsafeprotected.com/rfw/st/681307/60191576/skeleton.gif?gdpr=${GDPR}\u0026gdpr_consent=${GDPR_CONSENT_278}\u0026gdpr_pd=${GDPR_PD}\u0026ias_dspID=64"
          ],
          "tagline":"Try our Creative Assistant for free",
          "tagline_url":"https://ad.doubleclick.net/ddm/trackclk/N1224323.3286893UNSPLASH/B25600467.324553021;dc_trk_aid=517636252;dc_trk_cid=157730382;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=;ltd=",
          "sponsor":{
             "id":"D-bxv1Imc-o",
             "updated_at":"2022-06-29T13:14:00-04:00",
             "username":"mailchimp",
             "name":"Mailchimp",
             "first_name":"Mailchimp",
             "last_name":null,
             "twitter_username":"Mailchimp",
             "portfolio_url":"https://mailchimp.com/",
             "bio":"The all-in-one Marketing Platform built for growing businesses.",
             "location":null,
             "links":{
                "self":"https://api.unsplash.com/users/mailchimp",
                "html":"https://unsplash.com/@mailchimp",
                "photos":"https://api.unsplash.com/users/mailchimp/photos",
                "likes":"https://api.unsplash.com/users/mailchimp/likes",
                "portfolio":"https://api.unsplash.com/users/mailchimp/portfolio",
                "following":"https://api.unsplash.com/users/mailchimp/following",
                "followers":"https://api.unsplash.com/users/mailchimp/followers"
             },
             "profile_image":{
                "small":"https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-1.2.1\u0026crop=faces\u0026fit=crop\u0026w=32\u0026h=32",
                "medium":"https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-1.2.1\u0026crop=faces\u0026fit=crop\u0026w=64\u0026h=64",
                "large":"https://images.unsplash.com/profile-1609545740442-928866556c38image?ixlib=rb-1.2.1\u0026crop=faces\u0026fit=crop\u0026w=128\u0026h=128"
             },
             "instagram_username":"mailchimp",
             "total_collections":0,
             "total_likes":19,
             "total_photos":0,
             "accepted_tos":false,
             "for_hire":false,
             "social":{
                "instagram_username":"mailchimp",
                "portfolio_url":"https://mailchimp.com/",
                "twitter_username":"Mailchimp",
                "paypal_email":null
             }
          }
       },
       "topic_submissions":{
          "people":{
             "status":"rejected"
          },
          "technology":{
             "status":"approved",
             "approved_on":"2021-05-24T13:06:20-04:00"
          },
          "business-work":{
             "status":"approved",
             "approved_on":"2021-05-24T12:44:01-04:00"
          }
       },
       "user":{
          "id":"99F2rjzG4Js",
          "updated_at":"2022-06-30T08:19:30-04:00",
          "username":"nublson",
          "name":"Nubelson Fernandes",
          "first_name":"Nubelson",
          "last_name":"Fernandes",
          "twitter_username":"nublson",
          "portfolio_url":"https://nublson.com",
          "bio":"Developer ðŸ§‘ðŸ½â€ðŸ’» | Creator ðŸ“· | Tech Lover ðŸ“±\r\n  If you appreciate my work, consider supporting me making a donation and following me on Instagram â˜•â¬‡ï¸",
          "location":"Lisboa, Portugal",
          "links":{
             "self":"https://api.unsplash.com/users/nublson",
             "html":"https://unsplash.com/@nublson",
             "photos":"https://api.unsplash.com/users/nublson/photos",
             "likes":"https://api.unsplash.com/users/nublson/likes",
             "portfolio":"https://api.unsplash.com/users/nublson/portfolio",
             "following":"https://api.unsplash.com/users/nublson/following",
             "followers":"https://api.unsplash.com/users/nublson/followers"
          },
          "profile_image":{
             "small":"https://images.unsplash.com/profile-1648677385138-43d198854d6d?ixlib=rb-1.2.1\u0026crop=faces\u0026fit=crop\u0026w=32\u0026h=32",
             "medium":"https://images.unsplash.com/profile-1648677385138-43d198854d6d?ixlib=rb-1.2.1\u0026crop=faces\u0026fit=crop\u0026w=64\u0026h=64",
             "large":"https://images.unsplash.com/profile-1648677385138-43d198854d6d?ixlib=rb-1.2.1\u0026crop=faces\u0026fit=crop\u0026w=128\u0026h=128"
          },
          "instagram_username":"nublson",
          "total_collections":1,
          "total_likes":1,
          "total_photos":297,
          "accepted_tos":true,
          "for_hire":false,
          "social":{
             "instagram_username":"nublson",
             "portfolio_url":"https://nublson.com",
             "twitter_username":"nublson",
             "paypal_email":null
          }
       }
    }
 */


struct Photo: Identifiable, Codable {
    let id: String?
    let createdAt: String?
    let width, height: Double?
    let color, blurHash: String?
    let welcomeDescription, altDescription: String?
    let urls: Urls?
    let links: Links?
    let likes: Int?
    let sponsorship: Sponsorship?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height, color
        case blurHash = "blur_hash"
        case welcomeDescription = "description"
        case altDescription = "alt_description"
        case urls, links, likes
        case sponsorship
        case user
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

struct Links: Codable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

struct User: Identifiable, Codable {
    let id: String?
    let updatedAt: String?
    let username, name, firstName: String?
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks?
    let profileImage: UserProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int?
    let acceptedTos, forHire: Bool?
    let social: UserSocialMedia?

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }
}

struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

struct UserProfileImage: Codable {
    let small, medium, large: String?
}

struct UserSocialMedia: Codable {
    let instagramUsername: String?
    let portfolioURL: String?
    let twitterUsername: String?

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioURL = "portfolio_url"
        case twitterUsername = "twitter_username"
    }
}

struct Sponsorship: Codable {
    let impressionUrls: [String]?
    let tagline: String?
    let taglineURL: String?
    let sponsor: User?

    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline
        case taglineURL = "tagline_url"
        case sponsor
    }
}


