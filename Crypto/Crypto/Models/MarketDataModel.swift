//
//  MarketDataModel.swift
//  Crypto
//
//  Created by Fadel Sultan on 14/11/1444 AH.
//

import Foundation

//JSON Information
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON data:
 
 {
   "data": {
     "active_cryptocurrencies": 10094,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 749,
     "total_market_cap": {
       "btc": 43908299.1126254,
       "eth": 629073946.0781213,
       "ltc": 12381405133.081198,
       "bch": 10395482210.887156,
       "bnb": 3886706040.240802,
       "eos": 1304228993306.3845,
       "xrp": 2289629910014.654,
       "xlm": 12932351685555.227,
       "link": 185814898353.36935,
       "dot": 226264958583.3887,
       "yfi": 182904077.55860493,
       "usd": 1196573154054.4575,
       "aed": 4394893537526.631,
       "ars": 288508626146213.44,
       "aud": 1807512295612.6582,
       "bdt": 128386277077358.92,
       "bhd": 450339879113.6289,
       "bmd": 1196573154054.4575,
       "brl": 5925882563529.913,
       "cad": 1606578945291.2175,
       "chf": 1087732859961.6659,
       "clp": 955954258505649.1,
       "cny": 8477601139160.43,
       "czk": 26383480788377.55,
       "dkk": 8322166286448.78,
       "eur": 1116881381994.4314,
       "gbp": 961064822446.612,
       "hkd": 9379099353425.082,
       "huf": 413427990457356.1,
       "idr": 1.7831213484404126e+16,
       "ils": 4487951031717.428,
       "inr": 98601826669284.95,
       "jpy": 167466369558773.84,
       "krw": 1562688642000502.8,
       "kwd": 367432914988.6568,
       "lkr": 348603128899719.06,
       "mmk": 2.513150663233088e+15,
       "mxn": 21007636579157.11,
       "myr": 5477313612684.275,
       "ngn": 553971596761833.56,
       "nok": 13190771169933.988,
       "nzd": 1973404001117.617,
       "php": 67035614219873.64,
       "pkr": 343039764925233.75,
       "pln": 5016984740880.593,
       "rub": 96683110847600.39,
       "sar": 4488050347289.217,
       "sek": 12924665266203.809,
       "sgd": 1615852387235.141,
       "thb": 41566876514002.76,
       "try": 25081250224820.117,
       "twd": 36712898540752.664,
       "uah": 44361504226199.1,
       "vef": 119812869915.47305,
       "vnd": 2.8098469002966324e+16,
       "zar": 23345596933401.01,
       "xdr": 898737719998.2255,
       "xag": 50646478393.26063,
       "xau": 614236897.1707772,
       "bits": 43908299112625.4,
       "sats": 4.39082991126254e+15
     },
     "total_volume": {
       "btc": 861757.1818011607,
       "eth": 12346390.13290631,
       "ltc": 243001095.68932247,
       "bch": 204024788.8113325,
       "bnb": 76281634.93958654,
       "eos": 25597181498.927616,
       "xrp": 44936949471.917175,
       "xlm": 253814134635.90662,
       "link": 3646857800.866754,
       "dot": 4440742570.07854,
       "yfi": 3589729.1765401713,
       "usd": 23484296360.73962,
       "aed": 86255472103.36082,
       "ars": 5662355081333.499,
       "aud": 35474767490.827896,
       "bdt": 2519746803043.778,
       "bhd": 8838502809.73527,
       "bmd": 23484296360.73962,
       "brl": 116303112642.4071,
       "cad": 31531190508.747055,
       "chf": 21348164763.76678,
       "clp": 18761839205558.54,
       "cny": 166383891286.2042,
       "czk": 517809947317.2202,
       "dkk": 163333281188.94464,
       "eur": 21920242223.11438,
       "gbp": 18862140635.315186,
       "hkd": 184076960164.38593,
       "huf": 8114059235599.157,
       "idr": 349960635938105.9,
       "ils": 88081845831.33519,
       "inr": 1935188426520.8762,
       "jpy": 3286744182626.382,
       "krw": 30669786518235.18,
       "kwd": 7211346367.788686,
       "lkr": 6841787452461.54,
       "mmk": 49323833461058.18,
       "mxn": 412302049057.3257,
       "myr": 107499366591.28554,
       "ngn": 10872409354752.213,
       "nok": 258885951378.55783,
       "nzd": 38730606853.98453,
       "php": 1315660664564.8313,
       "pkr": 6732599236181.762,
       "pln": 98464816875.53067,
       "rub": 1897531145947.7659,
       "sar": 88083795027.93317,
       "sek": 253663278710.89276,
       "sgd": 31713193805.542816,
       "thb": 815803733802.2056,
       "try": 492251987587.8279,
       "twd": 720538135651.305,
       "uah": 870651918544.4214,
       "vef": 2351482594.6008625,
       "vnd": 551468810003642.7,
       "zar": 458187546030.64716,
       "xdr": 17638890606.47702,
       "xag": 994002668.5246838,
       "xau": 12055193.850858519,
       "bits": 861757181801.1606,
       "sats": 86175718180116.06
     },
     "market_cap_percentage": {
       "btc": 44.16457114464734,
       "eth": 19.11138474967641,
       "usdt": 6.950519508662166,
       "bnb": 4.06221946534678,
       "usdc": 2.415223376751766,
       "xrp": 2.2703232399739046,
       "steth": 1.1208513558112305,
       "ada": 1.1068273082726094,
       "doge": 0.850849930542006,
       "sol": 0.7044262216260189
     },
     "market_cap_change_percentage_24h_usd": 0.8496537961156958,
     "updated_at": 1685809058
   }
 }
 */



struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap:String {
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume:String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()   
        }
        return ""
    }
    
    var btcDominace:String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPerentString()
        }
        return ""
    }
}
