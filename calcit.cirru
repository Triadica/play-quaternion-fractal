
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |respo.calcit/ |triadica-space/ |quaternion/ |js-ffi/
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
              map-indexed points $ fn (idx point)
                let[] (x y z w) point $ hud-display (str |p idx)
                  map ([] x y z w) shorten-num
              group ({})
                if controls? (comp-axis)
                  group $ {}
                if controls? (comp-controls)
                  group $ {}
                comp-button
                  {} (:size 8)
                    :position $ [] 400 100 0
                    :color $ [] 0.4 0.8 0.5
                  fn (e d!) (d! :toggle-controls &unit)
                if controls?
                  group ({}) & $ -> points
                    map-indexed $ fn (idx point)
                      let[] (x y z w) point $ group ({})
                        comp-drag-point
                          {} (:size 16)
                            :position $ [] x y z
                          fn (position d!)
                            if (> idx 0)
                              let[] (next-x next-y next-z)
                                decode-map-as position $ Tuple Number Number Number
                                d! :move-point $ [] idx $ [] next-x next-y next-z w
                            , &unit
                        comp-slider
                          {} (:size 10)
                            :position $ &v+ ([] x y z) ([] 24 16 0)
                            :color $ [] 0.3 0.8 0.3
                          fn (xy d!)
                            d! :move-point $ [] idx $ [] x y z
                              + w $ .unwrap $ .first xy
                    rest
                  group $ {}
                match (.len points)
                  4 $ let
                      ps $ fold-line2 level (quaternion.core/quaternion 0 0 0 0)
                        app.fractal/point-quaternion $ .unwrap $ .get points 3
                        app.fractal/point-quaternion $ .unwrap $ .get points 1
                        app.fractal/point-quaternion $ .unwrap $ .get points 2
                        q-inverse $ app.fractal/point-quaternion $ .unwrap (.get points 3)
                        , mini-seg
                    object $ {} (:draw-mode :line-strip) (:vertex-shader line-vertex-shader) (:fragment-shader line-fragment-shader) (:packed-attrs ps)
                  5 $ let
                      ps $ fold-line3 level (quaternion.core/quaternion 0 0 0 0)
                        app.fractal/point-quaternion $ .unwrap $ .get points 4
                        app.fractal/point-quaternion $ .unwrap $ .get points 1
                        app.fractal/point-quaternion $ .unwrap $ .get points 2
                        app.fractal/point-quaternion $ .unwrap $ .get points 3
                        q-inverse $ app.fractal/point-quaternion $ .unwrap (.get points 4)
                        , mini-seg
                    object $ {} (:draw-mode :line-strip) (:vertex-shader line-vertex-shader) (:fragment-shader line-fragment-shader) (:packed-attrs ps)
                  6 $ let
                      ps $ fold-line4 level (quaternion.core/quaternion 0 0 0 0)
                        app.fractal/point-quaternion $ .unwrap $ .get points 5
                        app.fractal/point-quaternion $ .unwrap $ .get points 1
                        app.fractal/point-quaternion $ .unwrap $ .get points 2
                        app.fractal/point-quaternion $ .unwrap $ .get points 3
                        app.fractal/point-quaternion $ .unwrap $ .get points 4
                        q-inverse $ app.fractal/point-quaternion $ .unwrap (.get points 5)
                        , mini-seg
                    object $ {} (:draw-mode :line-strip) (:vertex-shader line-vertex-shader) (:fragment-shader line-fragment-shader) (:packed-attrs ps)
                  7 $ let
                      ps $ fold-line5 level (quaternion.core/quaternion 0 0 0 0)
                        app.fractal/point-quaternion $ .unwrap $ .get points 6
                        app.fractal/point-quaternion $ .unwrap $ .get points 1
                        app.fractal/point-quaternion $ .unwrap $ .get points 2
                        app.fractal/point-quaternion $ .unwrap $ .get points 3
                        app.fractal/point-quaternion $ .unwrap $ .get points 4
                        app.fractal/point-quaternion $ .unwrap $ .get points 5
                        q-inverse $ app.fractal/point-quaternion $ .unwrap (.get points 6)
                        , mini-seg
                    object $ {} (:draw-mode :line-strip) (:vertex-shader line-vertex-shader) (:fragment-shader line-fragment-shader) (:packed-attrs ps)
                  _ $ do (js/console.log "|unknown points:" points)
                    group $ {}
          :examples $ []
          :schema $ quote $ Fn app.state/Store
            -> $ Map Tag Dynamic
            :features :js-ffi
        'comp-controls $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-controls ()
            group ({})
              comp-button
                {} (:size 12)
                  :position $ [] 300 200 0
                fn (e d!) (d! :add-point &unit)
              comp-button
                {} (:size 12)
                  :position $ [] 300 160 0
                fn (e d!) (d! :remove-point &unit)
              comp-button
                {} (:size 12)
                  :position $ [] 340 180 0
                  :color $ [] 0.4 0.8 0.5
                fn (e d!) (d! :inc-level &unit)
              comp-button
                {} (:size 12)
                  :position $ [] 340 140 0
                  :color $ [] 0.4 0.8 0.5
                fn (e d!) (d! :dec-level &unit)
          :examples $ []
          :schema $ quote $ Fn
            -> $ Map Tag Dynamic
        'line-fragment-shader $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def line-fragment-shader (inline-shader |line.frag)
          :examples $ []
          :schema $ quote String
        'line-vertex-shader $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def line-vertex-shader (inline-shader |line.vert)
          :examples $ []
          :schema $ quote String
        'shorten-num $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn shorten-num (x)
            contract/expect-number |shorten-num $ js/parseFloat $ .!toFixed x 1
          :examples $ []
          :schema $ quote $ Fn Number (-> Number) (:features :js-ffi)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (|twgl.js :as twgl)
            app.config :refer $ inline-shader
            triadica.alias :refer $ object group
            triadica.comp.axis :refer $ comp-axis
            triadica.comp.drag-point :refer $ comp-drag-point comp-slider comp-button
            app.fractal :refer $ fold-line2 fold-line3 fold-line4 fold-line5
            quaternion.core :refer $ q-inverse
            triadica.hud :refer $ hud-display
            triadica.vector :refer $ &v+
            js-ffi.contract :as contract
    'app.config $ %{} 'FileEntry
      :defs $ {} $ 'inline-shader
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defmacro inline-shader (file) (println "|inline shader file:" file)
            read-file $ str |shaders/ file
          :examples $ []
          :schema $ quote $ Macro Syntax
            -> $ Expr String
            :capabilities :fs-read :log
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
                  wrap-position $ &q+ base branch-a
                  wrap-position $ &q+ base branch-b
                  wrap-position $ &q+ base v
                concat
                  fold-line2 (dec level) base branch-a a b full' minimal-seg
                  fold-line2 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b full' minimal-seg
                  fold-line2 (dec level) (&q+ base branch-b) (&q- v branch-b) a b full' minimal-seg
          :examples $ []
          :schema $ quote $ Fn Number quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion Number
            -> $ List $ Map Tag (List Number)
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
                  wrap-position $ &q+ base branch-a
                  wrap-position $ &q+ base branch-b
                  wrap-position $ &q+ base branch-c
                  wrap-position $ &q+ base v
                concat
                  fold-line3 (dec level) base branch-a a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-c) (&q- v branch-c) a b c full' minimal-seg
          :examples $ []
          :schema $ quote $ Fn Number quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion Number
            -> $ List $ Map Tag (List Number)
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
                concat
                  fold-line4 (dec level) base branch-a a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-c) (&q- branch-d branch-c) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-d) (&q- v branch-d) a b c d full' minimal-seg
          :examples $ []
          :schema $ quote $ Fn Number quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion Number
            -> $ List $ Map Tag (List Number)
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
                concat
                  fold-line5 (dec level) base branch-a a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-c) (&q- branch-d branch-c) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-d) (&q- branch-e branch-d) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-e) (&q- v branch-e) a b c d e full' minimal-seg
          :examples $ []
          :schema $ quote $ Fn Number quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion quaternion.core/Quaternion Number
            -> $ List $ Map Tag (List Number)
        'point-quaternion $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn point-quaternion (point)
            let[] (x y z w) point $ quaternion.core/quaternion w x y z
          :examples $ []
          :schema $ quote $ Fn (Tuple Number Number Number Number) (-> quaternion.core/Quaternion)
        'wrap-position $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn wrap-position (v4)
            match v4 $
              :quaternion w x y z
              {} $ :position $ [] x y z
          :examples $ []
          :schema $ quote $ Fn quaternion.core/Quaternion
            -> $ Map Tag $ List Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.fractal
          :require $ quaternion.core :refer $ &q+ &q- &q* q-length2
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *store
            state/Store :states ({}) :points
              [] ([] 0 0 0 0) ([] 40 100 0 0) ([] 40 200 0 0) ([] 0 300 40 0) ([] 0 400 40 0) ([] 0 500 0 0)
              , :level 4 :controls? true
          :examples $ []
          :schema $ quote $ Ref app.state/Store
        'canvas $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def canvas
            .unwrap $ query-selector |canvas
          :examples $ []
          :schema $ quote js-ffi.browser/DomElementHost
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op data)
            when dev? $ js/console.log |Dispatch: op data
            match (state/decode-op op data)
              (:some action)
                reset! *store $ state/update-store @*store action
              (:none) (js/console.warn |unknown-op op)
            , &unit
          :examples $ []
          :schema $ quote $ Fn Operation Payload (-> Unit) (:generics Operation Payload) (:features :js-ffi)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            if dev? $ load-console-formatter!
            twgl/setDefaults $ js-object $ :attribPrefix |a_
            inject-hud!
            reset-canvas-size! canvas
            let
                context $ .?!getContext canvas |webgl $ &js-object :antialias true
              if (js-present? context)
                reset! *gl-context $ Option :some context
                raise |WebGL-context-unavailable
            render-app!
            render-control!
            start-control-loop! 10 on-control-event
            add-watch! *store :change $ fn (v _p) (render-app!)
            set! js/window.onresize $ fn (event) (reset-canvas-size! canvas) (render-app!)
            setup-mouse-events! canvas
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (remove-watch! *store :change)
                add-watch! *store :change $ fn (v _p) (render-app!)
                replace-control-loop! 10 on-control-event
                set! js/window.onresize $ fn (event) (reset-canvas-size! canvas) (render-app!)
                setup-mouse-events! canvas
                render-app!
                hud! |ok~ |OK
              hud! |error build-errors
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            load-objects! (comp-container @*store) dispatch!
            paint-canvas!
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit)
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
            app.state :as state
            js-ffi.browser :refer $ query-selector
    'app.state $ %{} 'FileEntry
      :defs $ {}
        'Op $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum Op (:add-point) (:remove-point)
            :move-point Number $ Tuple Number Number Number Number
            :inc-level
            :dec-level
            :toggle-controls
          :examples $ []
          :schema $ quote EnumDef
        'Store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct Store
            :states $ Map Tag Unit
            :points $ List $ Tuple Number Number Number Number
            :level Number
            :controls? Bool
          :examples $ []
          :schema $ quote StructDef
        'decode-op $ %{} 'CodeEntry
          :doc "|Translate the renderer's raw callback into a typed application action."
          :code $ quote $ defn decode-op (raw-op data)
            match (try-decode-map-as raw-op 'Tag)
              (:ok tag)
                match tag
                  :add-point $ Option :some $ Op :add-point
                  :remove-point $ Option :some $ Op :remove-point
                  :move-point $ let[] (idx point)
                    decode-map-as data $ Tuple Number $ Tuple Number Number Number Number
                    Option :some $ Op :move-point idx point
                  :inc-level $ Option :some $ Op :inc-level
                  :dec-level $ Option :some $ Op :dec-level
                  :toggle-controls $ Option :some $ Op :toggle-controls
                  _ $ Option :none
              (:err _) (Option :none)
          :examples $ []
          :schema $ quote $ Fn Operation Payload
            -> $ Option app.state/Op
            :generics Operation Payload
        'update-store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn update-store (store op)
            match op
              (:add-point)
                let
                    points $ :points store
                  let[] (x y z w)
                    .unwrap $ .last points
                    assoc store :points $ conj points $ assert-type
                      [] x (+ y 100) z w
                      Tuple Number Number Number Number
              (:remove-point)
                assoc store :points $ let
                    xs $ :points store
                  if
                    <= (.len xs) 1
                    , xs $ butlast xs
              (:move-point idx point)
                assoc store :points $ assoc (:points store) idx point
              (:inc-level)
                assoc store :level $ if
                  < (:level store) 9
                  inc $ :level store
                  :level store
              (:dec-level)
                assoc store :level $ if
                  > (:level store) 3
                  - (:level store) 2
                  :level store
              (:toggle-controls)
                assoc store :controls? $ not $ :controls? store
          :examples $ []
          :schema $ quote $ Fn app.state/Store app.state/Op (-> app.state/Store)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.state
