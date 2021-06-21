//
//  Product.swift
//  EcommerceGapsi
//
//  Created by Arlen Peña on 21/06/21.
//

import Foundation

class Product: Decodable {
    
    var responseStatus : String?
    var responseMessage: String?
    var sortStrategy : String?
    var domainCode: String?
    var keyword : String?
    var numberOfProducts: Int?
    var productDetails: [ProductDetail]?
    
    
    init?() {
        return nil
    }
}

class ProductDetail: Decodable {
    var description : String?
    var productId: String?
    var usItemId: String?
    var productType: String?
    var title: String?
    var imageUrl : String?
    var productPageUrl : String?
    var department : String?
    var productCategory : String?
    var customerRating : Float?
    var numReviews : Int?
    var specialOfferBadge : String?
    var specialOfferText: String?
    var sellerId : String?
    var sellerName : String?
    var enableAddToCart: Bool?
    var canAddToCart: Bool?
    var cta: [String]?
    var showPriceAsAvailable: Bool?
    var seeAllName :String?
    var seeAllLink: String?
    var seeAllFacet: String?
    var seeAllFacetLink:String?
    var itemClassId: String?
    var primaryOffer: PrinaryOffter?
    var fulfillment : Fulfillment?
    var inventory: Inventory?
    var quantity : Int?
    var brand : [String]?
    var geoItemClassification: String?
    var wmtgPricePerUnitQuantity: String?
    var standardUpc : [String]?
    var isHeartable : Bool?
    var isWMPlusShipping : Bool?
    var virtualPack : Bool?
    var premiumBrand : Bool?
    var wfsEnabled : Bool?
    var preOrderAvailable : Bool?
    var blitzItem : Bool?
    var marketPlaceItem : Bool?
    var pickupDiscountEligible : Bool?
    var shippingPassEligible : Bool?
    var is_limited_qty : Bool?
    var imageProps: ImageProps?
    var visibleSwatches : [VisibleSwatches]?
    var shouldHaveSponsoredItemMargin : Bool?
    var shouldHaveSwatchesMargin : Bool?
    var shouldHaveSpecialOfferMargin : Bool?
    var countPerPack : Int?
    var highlightedTitleTerms : [String]?
    var esrb : String?
    var consoleKstem : String?
    var highlightedDescriptionTerms : [String]?
    var sellerBadge : Bool?
    var isbn : String?
    
    init?() {
        return nil
    }
             
}

class VisibleSwatches : Decodable {
    
    
    var  display_name : String?
    var  variantFieldId : String?
    var  swatch_image_url :String?
    var  product_image_url :String?
    var  productPageUrl : String?
    var  productSrcSet :String?
    var  swatchSrcSet : String?
    
    init?() {
        return nil
    }
        
}
class ImageProps : Decodable {
    var src : String?
    var srcSet : String?
    init?() {
        return nil
    }
}
class Inventory : Decodable {
    var availableOnline : Bool?
    init?() {
        return nil
    }
}


class PrinaryOffter : Decodable {
    var offerId :String?
    var offerPrice : Int?
    var currencyCode: String?
    init?() {
        return nil
    }
}
class Fulfillment : Decodable {
    var isS2H : Bool?
    var isS2S : Bool?
    var isSOI : Bool?
    var isPUT : Bool?
    var s2HDisplayFlags : [String]?
    init?() {
        return nil
    }
             
}
