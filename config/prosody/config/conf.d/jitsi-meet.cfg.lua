admins = {
    

    

    "focus@auth.jitsi.pydev.my.id",
    "jvb@auth.jitsi.pydev.my.id"
}

unlimited_jids = {
    "focus@auth.jitsi.pydev.my.id",
    "jvb@auth.jitsi.pydev.my.id"
}

plugin_paths = { "/prosody-plugins-custom", "/prosody-plugins/", "/prosody-plugins-contrib" }

muc_mapper_domain_base = "jitsi.pydev.my.id";
muc_mapper_domain_prefix = "muc";

recorder_prefixes = { "recorder@hidden.meet.jitsi" };

transcriber_prefixes = { "transcriber@hidden.meet.jitsi" };

http_default_host = "jitsi.pydev.my.id"







consider_bosh_secure = true;
consider_websocket_secure = true;


smacks_max_unacked_stanzas = 5;
smacks_hibernation_time = 60;
smacks_max_old_sessions = 1;




VirtualHost "jitsi.pydev.my.id"

  
  authentication = "token"
    app_id = "iqra-app"
    
    app_secret = "123456abcdef"
    
    allow_empty_token = false
    
    enable_domain_verification = false
  

    ssl = {
        key = "/config/certs/jitsi.pydev.my.id.key";
        certificate = "/config/certs/jitsi.pydev.my.id.crt";
    }
    modules_enabled = {
        "bosh";
        "features_identity";
        
        "websocket";
        "smacks"; -- XEP-0198: Stream Management
        
        "conference_duration";
        
        "muc_lobby_rooms";
        
        
        "muc_breakout_rooms";
        
        
        
        
        

    }

    main_muc = "muc.jitsi.pydev.my.id"
    
    lobby_muc = "lobby.jitsi.pydev.my.id"
    
    

    

    
    breakout_rooms_muc = "breakout.jitsi.pydev.my.id"
    

    c2s_require_encryption = true

    

    
VirtualHost "guest.jitsi.pydev.my.id"
    authentication = "jitsi-anonymous"
    modules_enabled = {
        
        "smacks"; -- XEP-0198: Stream Management
        
        
    }
    main_muc = "muc.jitsi.pydev.my.id"
    c2s_require_encryption = true
    
    
    lobby_muc = "lobby.jitsi.pydev.my.id"
    
    
    breakout_rooms_muc = "breakout.jitsi.pydev.my.id"
    

    

VirtualHost "auth.jitsi.pydev.my.id"
    ssl = {
        key = "/config/certs/auth.jitsi.pydev.my.id.key";
        certificate = "/config/certs/auth.jitsi.pydev.my.id.crt";
    }
    modules_enabled = {
        "limits_exception";
        "smacks";
    }
    authentication = "internal_hashed"
    smacks_hibernation_time = 15;



Component "internal-muc.jitsi.pydev.my.id" "muc"
    storage = "memory"
    modules_enabled = {
        "muc_hide_all";
        "muc_filter_access";
        }
    restrict_room_creation = true
    muc_filter_whitelist="auth.jitsi.pydev.my.id"
    muc_room_locking = false
    muc_room_default_public_jids = true
    muc_room_cache_size = 1000
    muc_tombstones = false
    muc_room_allow_persistent = false

Component "muc.jitsi.pydev.my.id" "muc"
    restrict_room_creation = true
    storage = "memory"
    modules_enabled = {
        "muc_hide_all";
        "muc_meeting_id";
        "token_verification";
        
        "muc_domain_mapper";
        
        "muc_password_whitelist";
        
        "muc_resource_validate";
        }

    anonymous_strict = false;
    -- The size of the cache that saves state for IP addresses
    rate_limit_cache_size = 10000;

    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    
    muc_password_whitelist = {
        "focus@auth.jitsi.pydev.my.id";
    }
    muc_tombstones = false
    muc_room_allow_persistent = false

Component "focus.jitsi.pydev.my.id" "client_proxy"
    target_address = "focus@auth.jitsi.pydev.my.id"

Component "speakerstats.jitsi.pydev.my.id" "speakerstats_component"
    muc_component = "muc.jitsi.pydev.my.id"


Component "endconference.jitsi.pydev.my.id" "end_conference"
    muc_component = "muc.jitsi.pydev.my.id"



Component "avmoderation.jitsi.pydev.my.id" "av_moderation_component"
    muc_component = "muc.jitsi.pydev.my.id"



Component "lobby.jitsi.pydev.my.id" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_tombstones = false
    muc_room_allow_persistent = false
    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    modules_enabled = {
        "muc_hide_all";
    }

    


Component "breakout.jitsi.pydev.my.id" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    muc_tombstones = false
    muc_room_allow_persistent = false
    modules_enabled = {
        "muc_hide_all";
        "muc_meeting_id";
        }


Component "metadata.jitsi.pydev.my.id" "room_metadata_component"
    muc_component = "muc.jitsi.pydev.my.id"
    breakout_rooms_component = "breakout.jitsi.pydev.my.id"




Component "polls.jitsi.pydev.my.id" "polls_component"
