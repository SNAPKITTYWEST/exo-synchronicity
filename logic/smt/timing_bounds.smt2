; logic/smt/timing_bounds.smt2
; Numeric constraint feasibility: skew, droop, thresholds

(declare-fun skew () Real)
(declare-fun pulse_width () Real)
(declare-fun v_peak_cell_0 () Real)
(declare-fun v_peak_cell_2 () Real)
(declare-fun v_threshold () Real)
(declare-fun false_trigger_voltage () Real)
(declare-fun jitter_rms () Real)
(declare-fun jitter_max () Real)

; Skew must be less than 1/4 of pulse width
(assert (< skew (/ pulse_width 4.0)))

; Peak voltage at every cell must exceed threshold
(assert (> v_peak_cell_0 v_threshold))
(assert (> v_peak_cell_2 v_threshold))

; Blocked paths must stay below 0.1 V false-trigger floor
(assert (< false_trigger_voltage 0.1))

; Jitter must stay within bound
(assert (< jitter_rms jitter_max))

; Physical parameter ranges
(assert (= pulse_width 0.5e-9))
(assert (= v_threshold 0.6))
(assert (= jitter_max 5e-12))
(assert (= skew 45e-12))
(assert (= v_peak_cell_0 1.72))
(assert (= v_peak_cell_2 1.61))
(assert (= false_trigger_voltage 0.03))
(assert (= jitter_rms 3.2e-12))

(check-sat)
(get-model)
