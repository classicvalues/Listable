//
//  TableListLayout.swift
//  ListableUI
//
//  Created by Kyle Van Essen on 11/19/19.
//

import Foundation


public extension LayoutDescription
{
    static func table(_ configure : @escaping (inout TableAppearance) -> () = { _ in }) -> Self
    {
        TableListLayout.describe(appearance: configure)
    }
}


///
/// `TableAppearance` defines the appearance and layout attribute for list layouts within a Listable list.
///
/// The below diagram shows where each of the properties on the `TableAppearance.Layout` values are
/// applied when laying out the list.
///
/// Note
/// ----
/// Do not edit this ASCII diagram directly.
/// Edit the `TableAppearance.monopic` file in this directory using Monodraw.
/// ```
/// ┌─────────────────────────────────────────────────────────────────┐
/// │                          padding.top                            │
/// │   ┌─────────────────────────────────────────────────────────┐   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                                                       ││   │
/// │   ││                      List Header                      ││   │
/// │   ││                                                       ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │                                                         │   │
/// │   │               headerToFirstSectionSpacing               │   │
/// │   │                                                         │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                                                       ││   │
/// │   ││                    Section Header                     ││   │
/// │   ││                                                       ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │               sectionHeaderBottomSpacing                │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                         Item                          ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │                       itemSpacing                       │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                         Item                          ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │               itemToSectionFooterSpacing                │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                                                       ││   │
/// │ p ││                    Section Footer                     ││ p │
/// │ a ││                                                       ││ a │
/// │ d │└───────────────────────────────────────────────────────┘│ d │
/// │ d │                                                         │ d │
/// │ i │               interSectionSpacingWithFooter             │ i │
/// │ n │                                                         │ n │
/// │ g │┌───────────────────────────────────────────────────────┐│ g │
/// │ . ││                                                       ││ . │
/// │ l ││                    Section Header                     ││ r │
/// │ e ││                                                       ││ i │
/// │ f │└───────────────────────────────────────────────────────┘│ g │
/// │ t │               sectionHeaderBottomSpacing                │ h │
/// │   │┌───────────────────────────────────────────────────────┐│ t │
/// │   ││                         Item                          ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │                       itemSpacing                       │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                         Item                          ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │                                                         │   │
/// │   │              interSectionSpacingWithNoFooter            │   │
/// │   │                                                         │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                                                       ││   │
/// │   ││                    Section Header                     ││   │
/// │   ││                                                       ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │               sectionHeaderBottomSpacing                │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                         Item                          ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │                       itemSpacing                       │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                         Item                          ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   │                                                         │   │
/// │   │               lastSectionToFooterSpacing                │   │
/// │   │                                                         │   │
/// │   │┌───────────────────────────────────────────────────────┐│   │
/// │   ││                                                       ││   │
/// │   ││                      List Footer                      ││   │
/// │   ││                                                       ││   │
/// │   │└───────────────────────────────────────────────────────┘│   │
/// │   └─────────────────────────────────────────────────────────┘   │
/// │                         padding.bottom                          │
/// └─────────────────────────────────────────────────────────────────┘
/// ```
public struct TableAppearance : ListLayoutAppearance
{
    /// How the layout should flow, either horizontally or vertically.
    public var direction: LayoutDirection
    
    /// If sticky section headers should be leveraged in the layout.
    public var stickySectionHeaders : Bool
    
    public var contentInsetAdjustmentBehavior : ListLayoutScrollViewProperties.ContentInsetAdjustmentBehavior
    
    /// Default sizing attributes for content in the list.
    public var sizing : Sizing
    
    /// Layout attributes for content in the list.
    public var layout : Layout
    
    public static var `default`: TableAppearance {
        return self.init()
    }
        
    /// Creates a new `TableAppearance` object.
    public init(
        direction : LayoutDirection = .vertical,
        stickySectionHeaders : Bool = true,
        contentInsetAdjustmentBehavior : ListLayoutScrollViewProperties.ContentInsetAdjustmentBehavior = .automatic,
        sizing : Sizing = Sizing(),
        layout : Layout = Layout()
    ) {
        self.direction = direction
        self.stickySectionHeaders = stickySectionHeaders
        self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
        self.sizing = sizing
        self.layout = layout
    }
}


extension TableAppearance
{
    public struct ItemLayout : Equatable, ItemLayoutsValue
    {
        public var itemSpacing : CGFloat?
        public var itemToSectionFooterSpacing : CGFloat?
        
        public var width : CustomWidth
            
        public init(
            itemSpacing : CGFloat? = nil,
            itemToSectionFooterSpacing : CGFloat? = nil,
            width : CustomWidth = .default
        ) {
            self.itemSpacing = itemSpacing
            self.itemSpacing = itemSpacing
            
            self.width = width
        }
        
        public static var defaultValue : Self {
            Self.init()
        }
    }
    
    
    public struct HeaderFooterLayout : Equatable, HeaderFooterLayoutsValue
    {
        public var width : CustomWidth
            
        public init(
            width : CustomWidth = .default
        ) {
            self.width = width
        }
        
        public static var defaultValue : Self {
            .init()
        }
    }
    
    public struct SectionLayout : Equatable, SectionLayoutsValue
    {
        public var width : CustomWidth

        /// Overrides the calculated spacing after this section
        public var customInterSectionSpacing : CGFloat?
        
        public var columns : Columns
        
        public init(
            width : CustomWidth = .default,
            customInterSectionSpacing : CGFloat? = nil,
            columns : Columns = .one
        ) {
            self.width = width
            self.customInterSectionSpacing = customInterSectionSpacing
            
            self.columns = columns
        }
        
        public static var defaultValue : Self {
            Self.init()
        }
        
        public struct Columns : Equatable
        {
            public var count : Int
            public var spacing : CGFloat
            
            public static var one : Columns {
                return Columns(count: 1, spacing: 0.0)
            }
            
            public init(count : Int = 1, spacing : CGFloat = 0.0)
            {
                precondition(count >= 1, "Columns must be greater than or equal to 1.")
                precondition(spacing >= 0.0, "Spacing must be greater than or equal to 0.")
                
                self.count = count
                self.spacing = spacing
            }
            
            func group<Value>(values : [Value]) -> [[Value]]
            {
                var values = values
                
                var grouped : [[Value]] = []
                
                while values.count > 0 {
                    grouped.append(values.safeDropFirst(self.count))
                }
                
                return grouped
            }
        }
    }
    
    /// Sizing options for the list.
    public struct Sizing : Equatable
    {
        /// The default height for items in a list.
        public var itemHeight : CGFloat
        
        /// The default height for section headers in a list.
        public var sectionHeaderHeight : CGFloat
        /// The default height for section footer in a list.
        public var sectionFooterHeight : CGFloat
        
        /// The default height for the list's header.
        public var listHeaderHeight : CGFloat
        /// The default height for the list's footer.
        public var listFooterHeight : CGFloat
        /// The default height for the list's overscroll footer.
        public var overscrollFooterHeight : CGFloat
        
        /// When providing the `ItemPosition` for items in a list, specifies the max spacing
        /// for items to be considered in the same group. For example, if this value is 1, and
        /// items are spaced 2pts apart, the items will be in a new group.
        public var itemPositionGroupingHeight : CGFloat
            
        public init(
            itemHeight : CGFloat = 50.0,
            sectionHeaderHeight : CGFloat = 60.0,
            sectionFooterHeight : CGFloat = 40.0,
            listHeaderHeight : CGFloat = 60.0,
            listFooterHeight : CGFloat = 60.0,
            overscrollFooterHeight : CGFloat = 60.0,
            itemPositionGroupingHeight : CGFloat = 0.0
        )
        {
            self.itemHeight = itemHeight
            self.sectionHeaderHeight = sectionHeaderHeight
            self.sectionFooterHeight = sectionFooterHeight
            self.listHeaderHeight = listHeaderHeight
            self.listFooterHeight = listFooterHeight
            self.overscrollFooterHeight = overscrollFooterHeight
            self.itemPositionGroupingHeight = itemPositionGroupingHeight
        }
        
        public mutating func set(with block: (inout Sizing) -> ())
        {
            var edited = self
            block(&edited)
            self = edited
        }
    }
    
    
    /// Layout options for the list.
    public struct Layout : Equatable
    {
        /// The padding to place around the outside of the content of the list.
        public var padding : UIEdgeInsets
        /// The width of the content of the list, which can be optionally constrained.
        public var width : WidthConstraint
        
        /// The spacing between the list header and the first section.
        /// Not applied if there is no list header.
        public var headerToFirstSectionSpacing : CGFloat

        /// The spacing to apply between sections, if the previous section has no footer.
        public var interSectionSpacingWithNoFooter : CGFloat
        /// The spacing to apply between sections, if the previous section has a footer.
        public var interSectionSpacingWithFooter : CGFloat
        
        /// The spacing to apply below a section header, before its items.
        /// Not applied if there is no section header.
        public var sectionHeaderBottomSpacing : CGFloat
        /// The spacing between individual items within a section in a list.
        public var itemSpacing : CGFloat
        /// The spacing between the last item in the section and the footer.
        /// Not applied if there is no section footer.
        public var itemToSectionFooterSpacing : CGFloat
        
        /// The spacing between the last section and the footer of the list.
        /// Not applied if there is no list footer.
        public var lastSectionToFooterSpacing : CGFloat
                
        /// Creates a new `Layout` with the provided options.
        public init(
            padding : UIEdgeInsets = .zero,
            width : WidthConstraint = .noConstraint,
            headerToFirstSectionSpacing : CGFloat = 0.0,
            interSectionSpacingWithNoFooter : CGFloat = 0.0,
            interSectionSpacingWithFooter : CGFloat = 0.0,
            sectionHeaderBottomSpacing : CGFloat = 0.0,
            itemSpacing : CGFloat = 0.0,
            itemToSectionFooterSpacing : CGFloat = 0.0,
            lastSectionToFooterSpacing : CGFloat = 0.0
        )
        {
            self.padding = padding
            self.width = width
            
            self.headerToFirstSectionSpacing = headerToFirstSectionSpacing
            
            self.interSectionSpacingWithNoFooter = interSectionSpacingWithNoFooter
            self.interSectionSpacingWithFooter = interSectionSpacingWithFooter
            
            self.sectionHeaderBottomSpacing = sectionHeaderBottomSpacing
            self.itemSpacing = itemSpacing
            self.itemToSectionFooterSpacing = itemToSectionFooterSpacing
            
            self.lastSectionToFooterSpacing = lastSectionToFooterSpacing
        }

        /// Easily mutate the `Layout` in place.
        public mutating func set(with block : (inout Layout) -> ())
        {
            var edited = self
            block(&edited)
            self = edited
        }
        
        /// Provides a width for layout.
        internal static func width(
            with width : CGFloat,
            padding : HorizontalPadding,
            constraint : WidthConstraint
        ) -> CGFloat
        {
            let paddedWidth = width - padding.leading - padding.trailing
            
            return constraint.clamp(paddedWidth)
        }
    }
}


extension ItemLayouts {
    
    /// Allows customization of an `Item`'s layout when it is presented within a `.table` style layout.
    public var table : TableAppearance.ItemLayout {
        get { self[TableAppearance.ItemLayout.self] }
        set { self[TableAppearance.ItemLayout.self] = newValue }
    }
}


extension HeaderFooterLayouts {
    
    /// Allows customization of a `HeaderFooter`'s layout when it is presented within a `.table` style layout.
    public var table : TableAppearance.HeaderFooterLayout {
        get { self[TableAppearance.HeaderFooterLayout.self] }
        set { self[TableAppearance.HeaderFooterLayout.self] = newValue }
    }
}


extension SectionLayouts {
    
    /// Allows customization of a `Section`'s layout when it is presented within a `.table` style layout.
    public var table : TableAppearance.SectionLayout {
        get { self[TableAppearance.SectionLayout.self] }
        set { self[TableAppearance.SectionLayout.self] = newValue }
    }
}


final class TableListLayout : ListLayout
{
    typealias LayoutAppearance = TableAppearance
    
    static var defaults: ListLayoutDefaults {
        .init(itemInsertAndRemoveAnimations: .fade)
    }
    
    var layoutAppearance: TableAppearance
    
    //
    // MARK: Public Properties
    //
    
    let appearance : Appearance
    let behavior : Behavior
    
    let content : ListLayoutContent
            
    var scrollViewProperties: ListLayoutScrollViewProperties {
        .init(
            isPagingEnabled: false,
            contentInsetAdjustmentBehavior: self.layoutAppearance.contentInsetAdjustmentBehavior,
            allowsBounceVertical: true,
            allowsBounceHorizontal: true,
            allowsVerticalScrollIndicator: true,
            allowsHorizontalScrollIndicator: true
        )
    }
        
    //
    // MARK: Initialization
    //
    
    init(
        layoutAppearance : LayoutAppearance,
        appearance : Appearance,
        behavior : Behavior,
        content : ListLayoutContent
    ) {
        self.layoutAppearance = layoutAppearance
        self.appearance = appearance
        self.behavior = behavior
        
        self.content = content
    }
    
    //
    // MARK: Performing Layouts
    //
    
    func updateLayout(in collectionView : UICollectionView)
    {
        
    }
    
    private func layout(
        headerFooter : ListLayoutContent.SupplementaryItemInfo,
        width : CustomWidth,
        viewWidth : CGFloat,
        defaultWidth : CGFloat,
        defaultHeight : CGFloat,
        contentBottom : CGFloat,
        after : (ListLayoutContent.SupplementaryItemInfo) -> ()
    ) {
        // Determines the position of the content within the list.
        
        let position = width.position(
            with: viewWidth,
            defaultWidth: defaultWidth
        )

        // The constraints we'll use to measure the content.
        
        let measureInfo = Sizing.MeasureInfo(
            sizeConstraint: self.direction.size(for: CGSize(width: position.width, height: .greatestFiniteMagnitude)),
            defaultSize: self.direction.size(for: CGSize(width: 0.0, height: defaultHeight)),
            direction: self.direction
        )
        
        // Measure the size of the content.

        let size = headerFooter.measurer(measureInfo)
        
        // Write the measurement and position out to the header/footer.
        
        self.direction.switch(
            vertical: {
                headerFooter.x = position.origin
                headerFooter.size = CGSize(width: position.width, height: size.height)
                headerFooter.y = contentBottom
            },
            horizontal: {
                headerFooter.y = position.origin
                headerFooter.size = CGSize(width: size.width, height: position.width)
                headerFooter.x = contentBottom
            }
        )
        
        after(headerFooter)
    }
    
    func layout(
        delegate : CollectionViewLayoutDelegate?,
        in context : ListLayoutLayoutContext
    ) {
        let layout = self.layoutAppearance.layout
        let sizing = self.layoutAppearance.sizing
        
        let viewWidth = self.direction.width(for: context.viewBounds.size)
        
        let rootWidth = CustomWidth.custom(.init(
            padding: self.direction.switch(
                vertical: HorizontalPadding(leading: layout.padding.left, trailing: layout.padding.right),
                horizontal: HorizontalPadding(leading: layout.padding.top, trailing: layout.padding.bottom)
            ),
            width: layout.width,
            alignment: .center
        ))

        let defaultWidth = rootWidth.position(
            with: viewWidth,
            defaultWidth: viewWidth
        ).width
                
        //
        // Item Positioning
        //
                
        /**
         Item positions are set and sent to the delegate first,
         in case the position affects the height calculation later in the layout pass.
         */
        self.setItemPositions()
        
        delegate?.listViewLayoutUpdatedItemPositions()
        
        //
        // Set Frame Origins
        //
        
        var contentBottom : CGFloat = self.direction.switch(
            vertical: layout.padding.top,
            horizontal: layout.padding.left
        )
        
        //
        // Header
        //
        
        self.layout(
            headerFooter: self.content.header,
            width: self.content.header.layouts.table.width.merge(with: rootWidth),
            viewWidth: viewWidth,
            defaultWidth: defaultWidth,
            defaultHeight: sizing.listHeaderHeight,
            contentBottom: contentBottom,
            after: { headerFooter in
                if headerFooter.isPopulated {
                    contentBottom = self.direction.maxY(for: headerFooter.defaultFrame)

                    if self.content.sections.isEmpty == false {
                        contentBottom += layout.headerToFirstSectionSpacing
                    }
                }
            }
        )
        
        //
        // Sections
        //
        
        self.content.sections.forEachWithIndex { sectionIndex, isLast, section in
            
            let sectionWidth = section.layouts.table.width.merge(with: rootWidth)
            
            let sectionPosition = sectionWidth.position(
                with: viewWidth,
                defaultWidth: defaultWidth
            )
            
            //
            // Section Header
            //
            
            let hasSectionFooter = section.footer.isPopulated
            
            self.layout(
                headerFooter: section.header,
                width: section.header.layouts.table.width.merge(with: sectionWidth),
                viewWidth: viewWidth,
                defaultWidth: sectionPosition.width,
                defaultHeight: sizing.sectionHeaderHeight,
                contentBottom: contentBottom,
                after: { header in
                    if header.isPopulated {
                        contentBottom = self.direction.maxY(for: header.defaultFrame)
                        
                        if section.items.isEmpty == false {
                            contentBottom += layout.sectionHeaderBottomSpacing
                        }
                    }
                }
            )
            
            //
            // Section Items
            //
            
            if section.layouts.table.columns.count == 1 {
                section.items.forEachWithIndex { itemIndex, isLast, item in
                    
                    let width = item.layouts.table.width.merge(with: sectionWidth)
                    
                    let itemPosition = width.position(
                        with: viewWidth,
                        defaultWidth: sectionPosition.width
                    )
                    
                    let measureInfo = Sizing.MeasureInfo(
                        sizeConstraint: self.direction.size(for: CGSize(width: itemPosition.width, height: .greatestFiniteMagnitude)),
                        defaultSize: self.direction.size(for: CGSize(width: 0.0, height: sizing.itemHeight)),
                        direction: self.direction
                    )
                    
                    let size = item.measurer(measureInfo)
                    
                    self.direction.switch(
                        vertical: {
                            item.x = itemPosition.origin
                            item.y = contentBottom
                            item.size = CGSize(width: itemPosition.width, height: size.height)
                            
                            contentBottom += size.height
                        },
                        horizontal: {
                            item.x = contentBottom
                            item.y = itemPosition.origin
                            item.size = CGSize(width: size.width, height: itemPosition.width)
                            
                            contentBottom += size.width
                        }
                    )

                    if isLast {
                        if hasSectionFooter {
                            contentBottom += item.layouts.table.itemToSectionFooterSpacing ?? layout.itemToSectionFooterSpacing
                        }
                    } else {
                        contentBottom += item.layouts.table.itemSpacing ?? layout.itemSpacing
                    }
                }
            } else {
                let itemWidth = round((sectionPosition.width - (section.layouts.table.columns.spacing * CGFloat(section.layouts.table.columns.count - 1))) / CGFloat(section.layouts.table.columns.count))
                
                let groupedItems = section.layouts.table.columns.group(values: section.items)
                
                groupedItems.forEachWithIndex { rowIndex, isLast, row in
                    var maxHeight : CGFloat = 0.0
                    var maxItemSpacing : CGFloat = 0.0
                    var maxItemToSectionFooterSpacing : CGFloat = 0.0
                    var columnXOrigin = sectionPosition.origin
                    
                    row.forEachWithIndex { columnIndex, isLast, item in
                        
                        self.direction.switch(
                            vertical: {
                                item.x = columnXOrigin
                                item.y = contentBottom
                            },
                            horizontal: {
                                item.y = columnXOrigin
                                item.x = contentBottom
                            }
                        )
                                                
                        let measureInfo = Sizing.MeasureInfo(
                            sizeConstraint: self.direction.size(for: CGSize(width: itemWidth, height: .greatestFiniteMagnitude)),
                            defaultSize: self.direction.size(for: CGSize(width: 0.0, height: sizing.itemHeight)),
                            direction: self.direction
                        )
                                                
                        let size = item.measurer(measureInfo)
                        
                        let height = self.direction.switch(vertical: size.height, horizontal: size.width)
                        
                        let itemSpacing = item.layouts.table.itemSpacing ?? layout.itemSpacing
                        let itemToSectionFooterSpacing = item.layouts.table.itemToSectionFooterSpacing ?? layout.itemToSectionFooterSpacing
                        
                        item.size = self.direction.size(for: CGSize(width: itemWidth, height: height))
                        
                        maxHeight = max(height, maxHeight)
                        maxItemSpacing = max(itemSpacing, maxItemSpacing)
                        maxItemToSectionFooterSpacing = max(itemToSectionFooterSpacing, maxItemToSectionFooterSpacing)
                        
                        columnXOrigin += (itemWidth + section.layouts.table.columns.spacing)
                    }
                    
                    contentBottom += maxHeight
                    
                    if isLast {
                        if hasSectionFooter {
                            contentBottom += maxItemToSectionFooterSpacing
                        }
                    } else {
                        contentBottom += maxItemSpacing
                    }
                }
            }
            
            //
            // Section Footer
            //
            
            self.layout(
                headerFooter: section.footer,
                width: section.footer.layouts.table.width.merge(with: sectionWidth),
                viewWidth: viewWidth,
                defaultWidth: sectionPosition.width,
                defaultHeight: sizing.sectionFooterHeight,
                contentBottom: contentBottom,
                after: { footer in
                    if footer.isPopulated {
                        contentBottom = self.direction.maxY(for: footer.defaultFrame)
                    }
                }
            )
            
            // Add additional padding from config.
            
            if isLast {
                if self.content.footer.isPopulated {
                    contentBottom += layout.lastSectionToFooterSpacing
                }
            } else {
                let additionalSectionSpacing: CGFloat
                if let customInterSectionSpacing = section.layouts.table.customInterSectionSpacing {
                    additionalSectionSpacing = customInterSectionSpacing
                } else {
                    additionalSectionSpacing = hasSectionFooter
                        ? layout.interSectionSpacingWithFooter
                        : layout.interSectionSpacingWithNoFooter
                }
                
                contentBottom += additionalSectionSpacing
            }
        }
        
        //
        // Footer
        //
        
        self.layout(
            headerFooter: self.content.footer,
            width: self.content.footer.layouts.table.width.merge(with: rootWidth),
            viewWidth: viewWidth,
            defaultWidth: defaultWidth,
            defaultHeight: sizing.listFooterHeight,
            contentBottom: contentBottom,
            after: { footer in
                if footer.isPopulated {
                    contentBottom = self.direction.maxY(for: footer.defaultFrame)
                }
            }
        )
        
        contentBottom += self.direction.switch(
            vertical: layout.padding.bottom,
            horizontal: layout.padding.right
        )
        
        //
        // Overscroll Footer
        //
        
        self.layout(
            headerFooter: self.content.overscrollFooter,
            width: self.content.overscrollFooter.layouts.table.width.merge(with: rootWidth),
            viewWidth: viewWidth,
            defaultWidth: defaultWidth,
            defaultHeight: sizing.overscrollFooterHeight,
            contentBottom: contentBottom,
            after: { _ in }
        )
        
        //
        // Remaining Calculations
        //
        
        self.content.contentSize = self.direction.size(for: CGSize(width: viewWidth, height: contentBottom))
    }
    
    private func setItemPositions()
    {
        self.content.sections.forEach { section in
            section.setItemPositions(with: self.layoutAppearance)
        }
    }
}


fileprivate extension ListLayoutContent.SectionInfo
{
    func setItemPositions(with appearance : TableAppearance)
    {
        if self.layouts.table.columns.count == 1 {
            let groups = ListLayoutContent.SectionInfo.grouped(
                items: self.items,
                groupingHeight: appearance.sizing.itemPositionGroupingHeight,
                appearance: appearance
            )
            
            groups.forEach { group in
                let itemCount = group.count
                
                group.forEachWithIndex { index, isLast, item in
                    
                    if itemCount == 1 {
                        item.position = .single
                    } else {
                        if index == 0 {
                            item.position = .first
                        } else if isLast {
                            item.position = .last
                        } else {
                            item.position = .middle
                        }
                    }
                }
            }
        } else {
            // If we have columns, every item will receive "single" positioning for now.
            // Depending on use, we may want to make this smarter.
            
            self.items.forEach { $0.position = .single }
        }
    }
    
    private static func grouped(items : [ListLayoutContent.ItemInfo], groupingHeight : CGFloat, appearance : TableAppearance) -> [[ListLayoutContent.ItemInfo]]
    {
        var all = [[ListLayoutContent.ItemInfo]]()
        var current = [ListLayoutContent.ItemInfo]()
        
        var lastSpacing : CGFloat = 0.0
        
        items.forEachWithIndex { index, isLast, item in
            let inNewGroup = groupingHeight == 0.0 ? lastSpacing > 0.0 : lastSpacing > groupingHeight
            
            if inNewGroup {
                all.append(current)
                current = []
            }
            
            current.append(item)
            
            lastSpacing = item.layouts.table.itemSpacing ?? appearance.layout.itemSpacing
        }
        
        if current.isEmpty == false {
            all.append(current)
        }
        
        return all
    }
}


fileprivate extension Array
{
    mutating func safeDropFirst(_ count : Int) -> [Element]
    {
        let safeCount = Swift.min(self.count, count)
        let values = self[0..<safeCount]
        
        self.removeFirst(safeCount)
        
        return Array(values)
    }
}


fileprivate func performLayout<Input>(for input : Input, _ block : (Input) -> ())
{
    block(input)
}
