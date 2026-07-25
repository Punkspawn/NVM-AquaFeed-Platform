PROGRAM PRG_AquaFeedMain

(* Saturating scan sequence supports diagnostics without silent wrap. *)
IF g_udiScanSequence < c_udiCounterMaximum THEN
    g_udiScanSequence := g_udiScanSequence + 1;
END_IF;

(* Approved call order as implementation is added:
   1. acquire and validate inputs
   2. evaluate hardwired-safety observations and standard-PLC permissions
   3. update monotonic time and communication health
   4. process accepted execution transfers
   5. execute six LineManager instances using prior-scan global permission
   6. execute Selector, Blower, and Dosing equipment blocks
   7. aggregate line readiness, alarms, health, recovery, and diagnostics
   8. execute SystemManager and publish the bounded global lifecycle
   9. arbitrate and write physical outputs once
  10. publish the bounded Modbus snapshot

   No unimplemented Function Block is called from this baseline. *)

END_PROGRAM
