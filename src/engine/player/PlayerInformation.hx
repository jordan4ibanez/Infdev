package src.engine.player;

typedef PlayerInformation = {
    var address : "127.0.0.1",    
    var ip_version : 4,           
    var connection_uptime : 200,  
    var protocol_version : 32,    
    var formspec_version : 2,     
    var lang_code : "fr",         

    // the following keys can be missing if no stats have been collected yet
    var min_rtt : 0.01,           
    var max_rtt : 0.2,            
    var avg_rtt : 0.02,           
    var min_jitter : 0.01,        
    var max_jitter : 0.5,         
    var avg_jitter : 0.03,        

    // The version information is provided by the client and may be spoofed
    // or inconsistent in engine forks. You must not use this for checking
    // feature availability of clients. Instead, do use the fields
    // `protocol_version` and `formspec_version` where it matters.
    // Use `core.protocol_versions` to map Luanti versions to protocol versions.
    // This version string is only suitable for analysis purposes.
    var version_string : "0.4.9-git",   // full version string

    
}