
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |respo.calcit/ |triadica-space/ |quaternion/ |memof/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-container (store)
            let
                points $ :points store
                level $ :level store
                controls? $ :controls? store
                mini-seg 4
              map-indexed points $ fn (idx p)
                hud-display (str |p idx) (map p shorten-num)
              group ({})
                if controls? $ memof1-call comp-axis
                if controls? $ memof1-call comp-controls
                memof1-call comp-button
                  {} (:size 8)
                    :position $ [] 400 100 0
                    :color $ [] 0.4 0.8 0.5
                  fn (e d!) (d! :toggle-controls nil)
                if controls? $ group ({}) & $ -> points
                  map-indexed $ fn (idx point)
                    group ({})
                      comp-drag-point
                        {} (:size 16)
                          :position $ take point 3
                        fn (p d!)
                          if (> idx 0)
                            d! :move-point $ [] idx $ conj p (last point)
                      comp-slider
                        {} (:size 10)
                          :position $ &v+ point $ [] 24 16 0
                          :color $ [] 0.3 0.8 0.3
                        fn (xy d!)
                          d! :move-point $ [] idx $ update point 3
                            fn (w)
                              + w $ * 1 $ first xy
                  rest
                case-default (count points)
                  do (js/console.log "|unknown points:" points) nil
                  4 $ let
                      ps $ fold-line2 level ([] 0 0 0) (nth points 3) (nth points 1) (nth points 2)
                        q-inverse $ nth points 3
                        , mini-seg
                    object $ {} (:draw-mode :line-strip)
                      :vertex-shader $ inline-shader |line.vert
                      :fragment-shader $ inline-shader |line.frag
                      :grouped-attributes ps
                  5 $ let
                      ps $ fold-line3 level ([] 0 0 0) (nth points 4) (nth points 1) (nth points 2) (nth points 3)
                        q-inverse $ nth points 4
                        , mini-seg
                    object $ {} (:draw-mode :line-strip)
                      :vertex-shader $ inline-shader |line.vert
                      :fragment-shader $ inline-shader |line.frag
                      :grouped-attributes ps
                  6 $ let
                      ps $ fold-line4 level ([] 0 0 0) (nth points 5) (nth points 1) (nth points 2) (nth points 3) (nth points 4)
                        q-inverse $ nth points 5
                        , mini-seg
                    object $ {} (:draw-mode :line-strip)
                      :vertex-shader $ inline-shader |line.vert
                      :fragment-shader $ inline-shader |line.frag
                      :grouped-attributes ps
                  7 $ let
                      ps $ fold-line5 level ([] 0 0 0) (nth points 6) (nth points 1) (nth points 2) (nth points 3) (nth points 4) (nth points 5)
                        q-inverse $ nth points 6
                        , mini-seg
                    object $ {} (:draw-mode :line-strip)
                      :vertex-shader $ inline-shader |line.vert
                      :fragment-shader $ inline-shader |line.frag
                      :grouped-attributes ps
          :examples $ []
        'comp-controls $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-controls ()
            group ({})
              comp-button
                {} (:size 12)
                  :position $ [] 300 200 0
                fn (e d!) (d! :add-point nil)
              comp-button
                {} (:size 12)
                  :position $ [] 300 160 0
                fn (e d!) (d! :remove-point nil)
              comp-button
                {} (:size 12)
                  :position $ [] 340 180 0
                  :color $ [] 0.4 0.8 0.5
                fn (e d!) (d! :inc-level nil)
              comp-button
                {} (:size 12)
                  :position $ [] 340 140 0
                  :color $ [] 0.4 0.8 0.5
                fn (e d!) (d! :dec-level nil)
          :examples $ []
        'shorten-num $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn shorten-num (x)
            js/parseFloat $ .!toFixed x 1
          :examples $ []
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (|twgl.js :as twgl)
            app.config :refer $ inline-shader
            triadica.alias :refer $ object group
            triadica.math :refer $ &v+
            triadica.core :refer $ %nested-attribute
            triadica.comp.axis :refer $ comp-axis
            triadica.comp.drag-point :refer $ comp-drag-point comp-slider comp-button
            app.fractal :refer $ fold-line2 fold-line3 fold-line4 fold-line5
            quaternion.core :refer $ q-inverse
            triadica.hud :refer $ hud-display
            memof.once :refer $ memof1-call
    'app.config $ %{} 'FileEntry
      :defs $ {} $ 'inline-shader
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defmacro inline-shader (file) (println "|inline shader file:" file)
            read-file $ str |shaders/ file
          :examples $ []
          :schema $ :: 'Macro $ {}
            :capabilities $ #{}
            :expansion $ :: 'Expr 'Dynamic
            :required $ [] 'Syntax
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.fractal $ %{} 'FileEntry
      :defs $ {}
        'fold-line2 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line2 (level base v a b full' minimal-seg)
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                []
                  {} $ :position $ take (&q+ base branch-a) 3
                  {} $ :position $ take (&q+ base branch-b) 3
                  {} $ :position $ take (&q+ base v) 3
                []
                  fold-line2 (dec level) base branch-a a b full' minimal-seg
                  fold-line2 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b full' minimal-seg
                  fold-line2 (dec level) (&q+ base branch-b) (&q- v branch-b) a b full' minimal-seg
          :examples $ []
        'fold-line3 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line3 (level base v a b c full' minimal-seg)
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
                branch-c $ &q* v' c
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                []
                  {} $ :position $ take (&q+ base branch-a) 3
                  {} $ :position $ take (&q+ base branch-b) 3
                  {} $ :position $ take (&q+ base branch-c) 3
                  {} $ :position $ take (&q+ base v) 3
                []
                  fold-line3 (dec level) base branch-a a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-c) (&q- v branch-c) a b c full' minimal-seg
          :examples $ []
        'fold-line4 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line4
            level base v a b c d full' minimal-seg
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
                branch-c $ &q* v' c
                branch-d $ &q* v' d
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                []
                  wrap-position $ &q+ base branch-a
                  wrap-position $ &q+ base branch-b
                  wrap-position $ &q+ base branch-c
                  wrap-position $ &q+ base branch-d
                  wrap-position $ &q+ base v
                []
                  fold-line4 (dec level) base branch-a a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-c) (&q- branch-d branch-c) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-d) (&q- v branch-d) a b c d full' minimal-seg
          :examples $ []
        'fold-line5 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line5
            level base v a b c d e full' minimal-seg
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
                branch-c $ &q* v' c
                branch-d $ &q* v' d
                branch-e $ &q* v' e
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                []
                  wrap-position $ &q+ base branch-a
                  wrap-position $ &q+ base branch-b
                  wrap-position $ &q+ base branch-c
                  wrap-position $ &q+ base branch-d
                  wrap-position $ &q+ base branch-e
                  wrap-position $ &q+ base v
                []
                  fold-line5 (dec level) base branch-a a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-c) (&q- branch-d branch-c) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-d) (&q- branch-e branch-d) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-e) (&q- v branch-e) a b c d e full' minimal-seg
          :examples $ []
        'wrap-position $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn wrap-position (v4)
            {} $ :position $ take v4 3
          :examples $ []
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.fractal
          :require $ quaternion.core :refer $ v-scale v+ &v+ &q+ &q- &q* q-inverse q-length2
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *store
            {}
              :states $ {}
              :points $ [] ([] 0 0 0 0) ([] 40 100 0 0) ([] 40 200 0 0) ([] 0 300 40 0) ([] 0 400 40 0) ([] 0 500 0 0)
              :level 4
              :controls? true
          :examples $ []
        'canvas $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def canvas (js/document.querySelector |canvas)
          :examples $ []
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op data)
            when dev? $ js/console.log |Dispatch: op data
            let
                store $ deref *store
                next $ case-default op
                  do (js/console.warn "|unknown op" op) store
                  :add-point $ update store :points $ fn (xs)
                    conj xs $ &v+ (last xs) ([] 0 100 0 0)
                  :remove-point $ update store :points $ fn (xs)
                    if
                      <= (count xs) 1
                      , xs $ butlast xs
                  :move-point $ update store :points $ fn (xs)
                    let
                        idx $ nth data 0
                        p $ nth data 1
                      assoc xs idx p
                  :inc-level $ update store :level $ fn (l)
                    if (< l 9) (inc l) l
                  :dec-level $ update store :level $ fn (l)
                    if (> l 3) (- l 2) l
                  :toggle-controls $ update store :controls? not
              reset! *store next
          :examples $ []
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            if dev? $ load-console-formatter!
            twgl/setDefaults $ js-object $ :attribPrefix |a_
            inject-hud!
            reset-canvas-size! canvas
            reset! *gl-context $ .!getContext canvas |webgl $ js-object (:antialias true)
            render-app!
            render-control!
            start-control-loop! 10 on-control-event
            add-watch *store :change $ fn (v _p) (render-app!)
            set! js/window.onresize $ fn (event) (reset-canvas-size! canvas) (render-app!)
            setup-mouse-events! canvas
          :examples $ []
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (remove-watch *store :change)
                add-watch *store :change $ fn (v _p) (render-app!)
                replace-control-loop! 10 on-control-event
                set! js/window.onresize $ fn (event) (reset-canvas-size! canvas) (render-app!)
                setup-mouse-events! canvas
                render-app!
                hud! |ok~ |OK
              hud! |error build-errors
          :examples $ []
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            load-objects! (comp-container @*store) dispatch!
            paint-canvas!
          :examples $ []
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require (|./calcit.build-errors :default build-errors) (|bottom-tip :default hud!)
            triadica.config :refer $ dev? dpr
            |twgl.js :as twgl
            touch-control.core :refer $ render-control! start-control-loop! replace-control-loop!
            triadica.core :refer $ on-control-event load-objects! paint-canvas! setup-mouse-events! reset-canvas-size!
            triadica.global :refer $ *gl-context
            triadica.hud :refer $ inject-hud!
            app.comp.container :refer $ comp-container
            quaternion.core :refer $ &v+
