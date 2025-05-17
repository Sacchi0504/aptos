module DeliveryApp::TrustScore {
    use std::signer;
    use aptos_framework::account;
    use std::vector;

    /// Error codes
    const E_NOT_REGISTERED: u64 = 1;
    const E_ALREADY_REGISTERED: u64 = 2;
    const E_INVALID_SCORE: u64 = 3;

    /// Struct storing trust score info for a delivery person
    struct DeliveryPersonProfile has key {
        trust_score: u64,
        total_deliveries: u64,
        positive_reviews: u64,
    }

    /// Initialize a new delivery person profile with a starting score
    public fun register_delivery_person(account: &signer) {
        let addr = signer::address_of(account);
        
        // Check if already registered
        assert!(!exists<DeliveryPersonProfile>(addr), E_ALREADY_REGISTERED);
        
        // Create new profile with default values
        let profile = DeliveryPersonProfile {
            trust_score: 50, // Start with a middle score (out of 100)
            total_deliveries: 0,
            positive_reviews: 0,
        };
        
        move_to(account, profile);
    }
    
    /// Update trust score after delivery completion with customer feedback
    public fun complete_delivery(
        owner_addr: address, 
        positive_review: bool
    ) acquires DeliveryPersonProfile {
        // Check if delivery person is registered
        assert!(exists<DeliveryPersonProfile>(owner_addr), E_NOT_REGISTERED);
        
        // Get delivery person profile
        let profile = borrow_global_mut<DeliveryPersonProfile>(owner_addr);
        
        // Update delivery count
        profile.total_deliveries = profile.total_deliveries + 1;
        
        // Update review count and adjust score
        if (positive_review) {
            profile.positive_reviews = profile.positive_reviews + 1;
            // Increase score but cap at 100
            if (profile.trust_score <= 95) {
                profile.trust_score = profile.trust_score + 5;
            } else {
                profile.trust_score = 100;
            }
        } else {
            // Decrease score but floor at 0
            if (profile.trust_score >= 3) {
                profile.trust_score = profile.trust_score - 3;
            } else {
                profile.trust_score = 0;
            }
        }
    }
}